FROM alpine
ARG TARGETARCH
ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-${TARGETARCH} /tini
RUN cp /tini /supervisord \
 && chmod +x /tini /supervisord
ENTRYPOINT ["/tini", "--"]
