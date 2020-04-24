Movie UPC API
=======

Movie UPC API

Runs on Docker, Go 1.13

Requires MongoDb container and stevenweathers/movie-upc-api-cronjob Docker image for the data download/import

```
docker build -t movieupcapi .

docker run -d -p "3000:3000" --name movieupcapi movieupcapi
```
