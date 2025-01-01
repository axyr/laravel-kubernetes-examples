#!/usr/bin/env bash

pwd=$(basename "$PWD")

set -e
set -o pipefail -o noclobber -o nounset

docker compose -f docker-compose.yml up -d --build

echo "Installing composer packages"
docker exec -it ${pwd}_php composer install