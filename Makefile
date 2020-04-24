# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOFMT=gofmt
BINARY_NAME=movie-upc-api
BINARY_UNIX=$(BINARY_NAME)_unix
BINARY_WINDOWS=$(BINARY_NAME).exe
GORELEASER=goreleaser release --rm-dist
NEXT_DOCKER_TAG=stevenweathers/$(BINARY_NAME):next
LATEST_DOCKER_TAG=stevenweathers/$(BINARY_NAME):latest

all: build
build-deps: 
	$(NPMBUILD)
	$(STATICPACKCMD)

build: 
	$(NPMBUILD)
	$(STATICPACKCMD)
	$(GOBUILD) -o $(BINARY_NAME) -v

clean: 
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_UNIX)
	rm -f $(BINARY_WINDOWS)
	rm -f *-packr.go
	rm -rf dist
	rm -rf release

# Cross compilation
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_UNIX) -v

build-windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GOBUILD) -o $(BINARY_WINDOWS) -v

dev: 
	$(GOBUILD) -o $(BINARY_NAME) -v

	./$(BINARY_NAME)

run:
	./$(BINARY_NAME)

gorelease:
	$(GORELEASER)

gorelease-dry:
	$(GORELEASER) --skip-publish

gorelease-snapshot:
	$(GORELEASER) --snapshot

build-next-image:
	docker build ./ -f ./build/Dockerfile -t $(NEXT_DOCKER_TAG)

push-next-image:
	docker push $(NEXT_DOCKER_TAG)

build-latest-image:
	docker build ./ -f ./build/Dockerfile -t $(LATEST_DOCKER_TAG)

push-latest-image:
	docker push $(LATEST_DOCKER_TAG)