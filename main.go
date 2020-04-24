package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

type movie struct {
	DVDTitle       string `json:"DVD_Title"`
	Studio         string
	Released       string
	Status         string
	Sound          string
	Versions       string
	Price          string
	Rating         string
	Year           string
	Genre          string
	Aspect         string
	UPC            string
	DVDReleaseDate string `json:"DVD_ReleaseDate"`
	ID             string
	Timestamp      string
}

// GetEnv gets environment variable matching key string
// and if it finds none uses fallback string
// returning either the matching or fallback string
func GetEnv(key string, fallback string) string {
	var result = os.Getenv(key)

	if result == "" {
		result = fallback
	}

	return result
}

// RespondWithJSON takes a payload and writes the response
func respondWithJSON(w http.ResponseWriter, code int, payload interface{}) {
	response, _ := json.Marshal(payload)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	w.Write(response)
}

func handleIndex(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Movie UPC API"))
}

func handleGetUPC(m *mongo.Collection) http.HandlerFunc {
	type emptyResponse struct{}

	return func(w http.ResponseWriter, r *http.Request) {
		UPC := r.URL.Path[len("/upc/"):]

		if UPC == "" {
			http.NotFound(w, r)
			return
		}

		var foundMovie = movie{}

		filter := bson.M{"UPC": UPC}
		ctx, _ := context.WithTimeout(context.Background(), 1*time.Second)
		err := m.FindOne(ctx, filter).Decode(&foundMovie)

		if err != nil {
			log.Println(err)

			respondWithJSON(w, 404, &emptyResponse{})
			return
		}

		respondWithJSON(w, 200, foundMovie)
	}
}

func main() {
	mongoHost := GetEnv("mongo_host", "localhost")
	mongoPort := GetEnv("mongo_port", "27017")
	mongoCollection := GetEnv("mongo_collection", "movieupc")
	mongoURL := "mongodb://" + mongoHost + ":" + mongoPort

	client, err := mongo.NewClient(
		options.Client().ApplyURI(mongoURL),
	)
	if err != nil {
		log.Fatal(err)
	}
	ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
	err = client.Connect(ctx)
	if err != nil {
		log.Fatal(err)
	}

	ctx, _ = context.WithTimeout(context.Background(), 2*time.Second)
	err = client.Ping(ctx, readpref.Primary())
	if err != nil {
		log.Fatal(err)
	}

	collection := client.Database(mongoCollection).Collection("movies")

	listenPort := fmt.Sprintf(":%s", "3000")

	http.HandleFunc("/", handleIndex)
	http.HandleFunc("/upc/", handleGetUPC(collection))

	log.Fatal(http.ListenAndServe(listenPort, nil))
}
