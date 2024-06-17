FROM alpine:3.20
RUN apk --no-ncache upgrade
RUN apk --no-cache add openjdk17-jre
