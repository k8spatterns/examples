# Multi stage Dockerfile for creating the random generator
# This Dockerfile is also included in random-generator-multi-stage.yml
# for an OpenShift multi-stage Docker build.
# You can use it standalone with Docker, too, of course.
FROM maven:3-jdk-8-alpine as builder

# Checkout source
RUN apk add git \
 && git clone \
    https://github.com/k8spatterns/random-generator.git \
    /tmp/source

# Run a plain mvn build for compiling the jar file
RUN mvn package -f /tmp/source
# ---------------------------------------------------------------
# Runtime
FROM openjdk:8-alpine

# Set a default environment, can be overwritten in the deployment
ENV BUILD_TYPE docker-multi-stage

# Copy jar file from builds stage
COPY --from=builder /tmp/source/target/random-generator*.jar /

# Start up the service
CMD java -jar /random-generator*.jar
