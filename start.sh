#! /usr/bin/env bash

container=NAME

run_arguments="--rm \
--name $container \
--env-file $(pwd)/.env \
--mount type=bind,source=$(pwd)/bind,dst=/bind \
--mount type=bind,source=$(pwd)/code,dst=/code \
caeneb/$container"

# Build the container
if [[ $1 == "build" ]]; then
  echo "building image"
  if docker images | grep -q "$container"; then
    echo 'image found; removing existing image'
    until docker rmi caeneb/$container:latest; do
    if rmi caeneb/$container:latest | grep -q "image is being used by stopped container"; then
      docker stop caeneb/$container:latest
    fi
    echo 'trying to delete {$container}'
    done
    else
      echo 'not found'
    fi
    docker build -t caeneb/$container .
else
  echo "running without build"
fi

docker run $run_arguments