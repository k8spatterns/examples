FROM alpine
ENV KUBECTL_VERSION=v1.9.1
RUN apk update \
 && apk add curl \
 && curl -L -O https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz \
 && tar zvxf kubernetes-client-linux-amd64.tar.gz kubernetes/client/bin/kubectl \
 && mv kubernetes/client/bin/kubectl / \
 && apk del curl \
 && rm -rf kubernetes \
 && rm -f kubernetes-client-linux-amd64.tar.gz \
 && rm -rf /var/cache/apk/*
ENTRYPOINT [ \
  "/bin/ash", "-c", \
  "/kubectl proxy \
     --server https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT \
     --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
     --token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token) \
     --accept-paths='^.*' \
  "]
