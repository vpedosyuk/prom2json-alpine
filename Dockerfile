FROM golang:alpine AS builder

RUN \
  apk update \
  && apk add --no-cache git

RUN go get -v github.com/prometheus/prom2json/cmd/prom2json

FROM alpine

RUN \
  apk update \
  && apk add --no-cache socat nmap-ncat netcat-openbsd

COPY --from=builder /go/bin/prom2json /usr/bin/prom2json

ENTRYPOINT [ "prom2json" ]
