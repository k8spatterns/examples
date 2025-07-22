# Tini & supervisord (for book example)

Simple image used in Example-5 for the "Entrypoint Rewriting" pattern.
It does not use a full [supervisord](http://supervisord.org/) but instead the minimalistic
init replacement [Tini](https://github.com/krallin/tini)

It's meant for demonstration purposes only.

Building instructions with Podman for arm64 and amd64:

```
IMAGE="docker.io/k8spatterns/supervisord"
podman manifest create $IMAGE
podman build -f Dockerfile --platform linux/amd64 --manifest $IMAGE .
podman build -f Dockerfile --platform linux/arm64/v8 --manifest $IMAGE .
podman manifest push $IMAGE
podman image tag $IMAGE docker.io/k8spatterns/tini
podman manifest push docker.io/k8spatterns/tini
```
