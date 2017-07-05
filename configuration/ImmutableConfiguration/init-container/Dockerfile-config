FROM busybox

# Build arg filled in with `docker build --build-arg config=...`
ARG config

# Add the specified property
ADD ${config} /config-src/demo.properties

# Entrypoint specifies the copy command and the source file to copy
# A used of this image has to specify the target directory
# The 'sh -c ... --' trick is required to copy the content of the 
# directory and not the directory itself. So we need a shell for 
# wildcard expansion
ENTRYPOINT [ "sh", "-c", "cp /config-src/* $1", "--" ]
