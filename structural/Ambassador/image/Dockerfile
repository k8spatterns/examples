# Imagename: k8spatterns/random-generator-log-ambassador
# Simple image for exposing the log file created by random-exporter

# Yes, I know. But still the best language for quick and small system related tasks
FROM node

# HTTP port exposed
EXPOSE 9009

# Run a mini-http server just logging out POST requests
COPY log_ambassador.js /opt
CMD node /opt/log_ambassador.js
