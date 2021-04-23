#!/bin/bash

RUNNING_CLIENT_CONTAINERS=$(sudo docker ps | grep stackoverflow-client | awk '{print $1}')
ALL_CLIENT_CONTAINERS=$(sudo docker ps -a | grep stackoverflow-client | awk '{print $1}')

# Stop and remove old containers
sudo docker stop "${RUNNING_CLIENT_CONTAINERS}"
sudo docker container rm "${ALL_CLIENT_CONTAINERS}"

# Build API app's image
sudo docker build -t adenicole/stackoverflow-client .

# Deploy the API app in a container and map exposed port to localhost:80
sudo docker run -d -i -p 80:3000 --network stackoverflow-net --name stackoverflow-client adenicole/stackoverflow-client
