#!/usr/bin/env bash

port=5000
registry="localhost:${port}"

pwd=$(basename "$PWD")

image="${pwd}-php"

echo "Build the image ${image}"
docker build -t "${image}" -f docker/php/Dockerfile .

if [ "$(docker ps -q -f name=registry)" ]; then
  echo "Registry is running."
else
  if [ "$(docker ps -aq -f name=registry)" ]; then
    echo "Starting registry container."
    docker start registry
  else
    echo "Registry container does not exist. Creating and starting it."
    docker run -d -p "${port}:${port}" --restart=always --name registry registry:2
  fi
fi

docker tag "${image}" "${registry}/${image}"
docker push "${registry}/${image}"
