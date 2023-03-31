For proper crosscompiling, user Docker's buildx:

----
docker buildx create --use
docker buildx build --platform linux/arm64/v8,linux/amd64 --push -t k8spatterns/random-generator-exporter .
----
