# Image used a init container
FROM hairyhenderson/gomplate:v3
USER 1000
#CMD ls -laR /params && id && cat /params/config.yml
COPY in /in
ENTRYPOINT [ "/gomplate", "--input-dir=/in" ]

