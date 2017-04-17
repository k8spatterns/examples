FROM busybox
ARG version=1.5.1
ADD https://github.com/hairyhenderson/gomplate/releases/download/v${version}/gomplate_linux-amd64 /gomplate
RUN chmod a+x /gomplate
COPY gomplate_wrapper.sh /gomplate_wrapper.sh
ENTRYPOINT [ "/gomplate_wrapper.sh" ]
