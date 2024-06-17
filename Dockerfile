FROM alpine:3.20
RUN apk --no-cache upgrade
RUN apk --no-cache add openjdk17-jre
