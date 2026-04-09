#!/bin/bash

#Build an image based on the secrets file passwd.txt, if you want to change users password, please, edit passwd.txt

set -e

IMAGE_NAME="wineddrop"
TAG="latest"
PLATFORM=$(docker info --format '{{.Architecture}}')  # Auto-detect

echo "Build for platform: $PLATFORM"

docker build \
  --tag "$IMAGE_NAME:$TAG" \
  --secret id=pusrs,src=$PWD/passwd.txt \
  .

echo "Build completed for $PLATFORM, now it is possible to execute run.sh"

