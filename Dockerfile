FROM alpine:latest

RUN echo creating a docker image

RUN apk add --no-cache git

RUN echo DONE
