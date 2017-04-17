# Image used  a init container
FROM k8spatterns/gomplate
COPY in /in
CMD [ "-u", "1000:1000",\
      "/in", "/params", "/out" ]
