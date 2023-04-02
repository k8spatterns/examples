#!/bin/sh
repo=k8spatterns/example-configuration-template-init
echo "Building ---> ${repo}"
extra_args=""
if [ "x$1" == "x-p" ]; then
  extra_args="--push"
fi
docker buildx create --use
docker buildx build --platform linux/arm64/v8,linux/amd64 $extra_args -t $repo .
