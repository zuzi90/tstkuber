#FROM golang:1.22 as builder
#WORKDIR /app
#COPY . .
#RUN go build -o app
#
#FROM gcr.io/distroless/static
#COPY --from=builder /app/app /app/app
#ENTRYPOINT ["/app/app"]
FROM golang:1.22-alpine3.18 AS builder

ADD . /src
WORKDIR /src

RUN go mod download
RUN go build -o app

FROM alpine:3.18

COPY --from=builder /src/app /app/

ENTRYPOINT ["/app/app"]