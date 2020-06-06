FROM golang:alpine AS builder

RUN \
  apk update \
  && apk add --no-cache git

RUN go get -v github.com/prometheus/prom2json/cmd/prom2json

FROM alpine

COPY --from=builder /go/bin/prom2json /usr/bin/prom2json

RUN \
  apk update \
  && apk add --no-cache netcat-openbsd

ENTRYPOINT [ "prom2json" ]
