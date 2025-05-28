FROM golang:1.22 as builder
WORKDIR /app
COPY . .
RUN go build -o app main.go

FROM debian:bookworm-slim
COPY --from=builder /app/app /app
EXPOSE 3000
ENTRYPOINT ["/app"]
