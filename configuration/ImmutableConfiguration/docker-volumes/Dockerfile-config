FROM scratch

# Build arg filled in with `docker build --build-arg config=...`
ARG config

# Add the specified property
ADD ${config} /config/demo.properties

# Create volume and copy property into it
VOLUME /config

