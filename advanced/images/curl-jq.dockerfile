# Image name: k8spatterns/curl-jq
FROM alpine
RUN apk add --update \
    curl \
    jq \
    bind-tools \
    iputils \
 && rm -rf /var/cache/apk/*
ENTRYPOINT ["curl"]
