FROM alpine:latest

ENV CONFIG_JSON=none

ADD run.sh /run.sh



EXPOSE 8080
