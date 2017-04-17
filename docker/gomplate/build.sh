#!/bin/sh -x
gomplate_version=1.5.1
repo="k8spatterns/gomplate"
docker build --build-arg version=${gomplate_version} -t ${repo}:${gomplate_version} .
docker tag ${repo}:${gomplate_version} ${repo}:latest
if [ "x$1" == "x-p" ]; then
  docker push ${repo}:${gomplate_version}
  docker push ${repo}:latest
fi
