# Imagename: k8spatterns/random-generator-exporter:1.0
# Simple image for exposing the log file created by random-exporter

# Yes, I know. But still the best language for quick and small system related tasks
FROM perl

# Default
ENV LOG_FILE=/logs/random-generator.log

# Some handy Perl libraries
RUN cpanm install Net::Server::HTTP Text::CSV

# HTTP port exposed
EXPOSE 9889

# Run the exporter for opening up an Prometheus exporter for our service
COPY random_generator_exporter.pl /
CMD perl /random_generator_exporter.pl
