# syntax=docker/dockerfile:1
FROM golang:1.18-alpine

ARG BUILD_DATE=now
ARG COMMIT_HASH=unknown

LABEL org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.name="devdrops/staticcheck" \
      org.label-schema.description="Docker image with https://staticcheck.io" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vcs-ref="$COMMIT_HASH" \
      org.label-schema.vcs-url="https://github.com/devdrops/go-staticcheck"

ENV CGO_ENABLED=0

RUN apk add --no-cache --virtual .build-deps git \
    && go install honnef.co/go/tools/cmd/staticcheck@latest \
    && apk del .build-deps

WORKDIR /code

CMD ["staticcheck"]
