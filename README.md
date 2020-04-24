Movie UPC API
=======

![](https://github.com/StevenWeathers/Movie-UPC-API/workflows/Go/badge.svg)
![](https://github.com/StevenWeathers/Movie-UPC-API/workflows/Node.js%20CI/badge.svg)
![](https://github.com/StevenWeathers/Movie-UPC-API/workflows/Docker/badge.svg)
![](https://img.shields.io/docker/cloud/build/stevenweathers/movie-upc-api.svg)
[![](https://img.shields.io/docker/pulls/stevenweathers/movie-upc-api.svg)](https://hub.docker.com/r/stevenweathers/movie-upc-api)
[![](https://goreportcard.com/badge/github.com/stevenweathers/Movie-UPC-API)](https://goreportcard.com/report/github.com/stevenweathers/Movie-UPC-API)

Movie UPC API

Runs on Docker, Go 1.13

Requires MongoDb container and stevenweathers/movie-upc-api-cronjob Docker image for the data download/import

```
docker build -t movieupcapi .

docker run -d -p "3000:3000" --name movieupcapi movieupcapi
```
