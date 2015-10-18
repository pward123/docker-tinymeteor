#!/bin/bash

set -e

PROJECT_NAME=tinymeteor
CONTAINER_NAME=ddipward/$PROJECT_NAME
TAG=$(echo ${CIRCLE_BRANCH} | sed 's/release\/v//' | sed 's/feature\///')

docker login --username="$DOCKER_USER" --password="$DOCKER_PASS" --email="$DOCKER_EMAIL"
docker tag $CONTAINER_NAME:latest $CONTAINER_NAME:$TAG
docker push $CONTAINER_NAME:$TAG
rm -rf ~/.docker
