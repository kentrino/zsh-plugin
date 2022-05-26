#!/bin/bash

# shellcheck disable=SC2046
docker-force-clean-all() {
    docker stop $(docker ps -qa)

    # Remove all containers
    docker rm $(docker ps -qa)

    # Remove all images
    docker rmi -f $(docker images -qa)

    # Remove all volumes
    docker volume rm $(docker volume ls -qf)

    # Remove all networks
    docker network rm $(docker network ls -q)
}
