FROM golang:1.22 as builder
WORKDIR /app
COPY . .
RUN go build -o app

FROM gcr.io/distroless/static
COPY --from=builder /app/app /app/app
ENTRYPOINT ["/app/app"]