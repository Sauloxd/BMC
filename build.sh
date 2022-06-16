#!/bin/sh
IMAGE_NAME=sauloxd/breakable-toy:build

echo Building image $IMAGE_NAME

docker build \
    --build-arg RUBY_VERSION=3.1.0 \
    --build-arg PG_MAJOR=14 \
    -t $IMAGE_NAME . -f Dockerfile.build
