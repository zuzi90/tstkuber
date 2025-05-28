FROM golang:1.23.9 AS builder
WORKDIR /app
COPY . .
RUN go build -o app main.go

FROM debian:bookworm-slim
COPY --from=builder /app/app /app
EXPOSE 3000
ENTRYPOINT ["/app"]

