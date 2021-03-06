FROM golang:1.10-alpine AS build

RUN apk add --no-cache git
COPY . /go/src/sblogdriver
WORKDIR /go/src/sblogdriver
RUN go get && go build -o /sblogdriver

FROM alpine:latest AS finalimage
WORKDIR /
COPY --from=build /sblogdriver .
RUN mkdir -p /run/docker/plugins /var/log/docker /mnt/logs

CMD ["/sblogdriver"]