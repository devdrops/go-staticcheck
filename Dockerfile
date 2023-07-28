# syntax=docker/dockerfile:1
FROM golang:1.20-alpine

# Image information
ARG VCS_REF
ARG BUILD_DATE
ARG BUILD_VERSION

LABEL maintainer="Davi Marcondes Moreira <davi.marcondes.moreira@gmail.com>" \
      org.label-schema.name="DevDrops/Go-Staticcheck" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/devdrops/go-staticcheck" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.version=$BUILD_VERSION

ENV CGO_ENABLED=0

RUN apk update && \
    apk upgrade && \
    apk add --no-cache --virtual .build-deps git \
    && go install honnef.co/go/tools/cmd/staticcheck@latest \
    && apk del .build-deps && \
    rm -rf /var/cache/apk/*

CMD ["staticcheck"]
