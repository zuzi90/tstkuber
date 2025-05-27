#FROM golang:1.22 as builder
#WORKDIR /app
#COPY . .
#RUN go build -o app
#
#FROM ghcr.io/distroless/static
#COPY --from=builder /app/app /app/app
#ENTRYPOINT ["/app/app"]
#FROM golang:1.22 as builder
#WORKDIR /app
#COPY . .
#RUN go build -o app
#
#FROM alpine
#COPY --from=builder /app/app /app/app
#ENTRYPOINT ["/app/app"]
#
#FROM golang:1.23.9 as builder
#
#WORKDIR /app
#COPY main.go .
#
#RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o server .
#
#FROM alpine:latest
#WORKDIR /app
#COPY --from=builder /app/server .
#
#EXPOSE 3000
#CMD ["./server"]
FROM golang:1.21 as builder
WORKDIR /app
COPY . .
RUN go build -o app main.go

FROM debian:bullseye-slim
WORKDIR /root/
COPY --from=builder /app/app .
CMD ["./app"]



#FROM golang:1.22-alpine3.18 AS builder
#
#ADD . /src
#WORKDIR /src
#
#RUN go mod download
#RUN go build -o app
#
#FROM alpine:3.18
#
#COPY --from=builder /src/app /app/
#
#ENTRYPOINT ["/app/app"]

# Стадия 1: билдим бинарник
#FROM golang:1.22 as builder
#
#WORKDIR /src
#COPY . .
#
## Кросс-компиляция под Linux ARM64 (если твой кластер ARM)
#RUN GOARCH=arm64 GOOS=linux go build -o app
#
## Стадия 2: минимальный образ (alpine)
#FROM alpine:3.19
#
#WORKDIR /app
#
## Берём бинарник из builder-стадии
#COPY --from=builder /src/app /app/app
#
## Не забудь выставить исполняемые права!
#RUN chmod +x /app/app
#
##CMD ["/app/app"]
#ENTRYPOINT ["/app/app"]