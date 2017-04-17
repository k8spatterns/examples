#!/bin/sh
repo=k8spatterns/example-config-cm-template-init
echo "Building ---> ${repo}"
docker build --no-cache -t ${repo} .
if [ "x$1" == "x-p" ]; then
  docker push ${repo}
fi
