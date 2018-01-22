FROM alpine
RUN apk add --update \
    curl \
    jq \
 && rm -rf /var/cache/apk/*
ENTRYPOINT ["curl"]
