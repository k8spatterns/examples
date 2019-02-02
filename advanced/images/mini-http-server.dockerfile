# Image name: k8spatterns/mini-http-server
# Possibly one of the simplest HTTP Server
FROM alpine

# Message to send out as response on any request
ENV MESSAGE="Welcome to Kubernetes Patterns !"

# Install 'nc'
RUN apk update \
 && apk add netcat-openbsd

CMD [ \
  "/bin/ash", "-c", \
  "while true ; do \
     echo -e \"HTTP/1.1 200 OK\n\n $MESSAGE\n\" | nc -l -p 8080 -q 1; \
  done \
"]
