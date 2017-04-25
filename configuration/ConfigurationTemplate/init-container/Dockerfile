# Image used  a init container
FROM k8spatterns/gomplate
COPY in /in
CMD [ "--input-dir",  "/in",         \
      "--output-dir", "/out",        \
      "--datasource", "/params"      \
      "--chown",      "1000:1000" ]
