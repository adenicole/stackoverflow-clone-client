#!/bin/bash

RUNNING_CLIENT_CONTAINERS=$(docker ps | grep stackoverflow-client | awk '{print $1}')
ALL_CLIENT_CONTAINERS=$(docker ps -a | grep stackoverflow-client | awk '{print $1}')

# Stop and remove old containers
docker stop "${RUNNING_CLIENT_CONTAINERS}"
docker container rm "${ALL_CLIENT_CONTAINERS}"

# Build API app's image
docker build -t adenicole/stackoverflow-client .

# Deploy the API app in a container and map exposed port to localhost:80
docker run -d -i -p 80:3000 --network stackoverflow-net --name stackoverflow-client adenicole/stackoverflow-client
