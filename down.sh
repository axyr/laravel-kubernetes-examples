#!/usr/bin/env bash

pwd=$(basename "$PWD")

set -e
set -o pipefail -o noclobber -o nounset

containers=("mysql" "redis" "php" "nginx")

for container in "${containers[@]}"; do
    container_name="${pwd}_${container}"

    if [[ $(docker ps -a -q -f name="$container_name") ]]; then
        echo "Stopping and removing existing container: $container_name"
        docker stop "$container_name" >/dev/null 2>&1
        docker rm "$container_name" >/dev/null 2>&1
    else
        echo "Container $container_name does not exist."
    fi
done
