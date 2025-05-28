#FROM golang:1.23.9 AS builder
#WORKDIR /app
#COPY . .
#RUN go build -o app main.go
#
#FROM debian:bookworm-slim
#COPY --from=builder /app/app /app
#EXPOSE 3000
#ENTRYPOINT ["/app"]
#





# Этап сборки
#FROM golang:1.23.9 AS builder
#
#WORKDIR /app
#COPY . .
#
#RUN go mod download
#
#RUN GOARCH=arm64 GOOS=linux go build -o app main.go
#
#FROM debian:bookworm-slim
#
#COPY --from=builder /app/app /app
#
#EXPOSE 3000
#
#ENTRYPOINT ["/app"]


#FROM golang:1.23.9 AS builder
#
#WORKDIR /app
#
#COPY . .
#
#RUN go mod download
#
#RUN go build -o app main.go
#
#FROM debian:bookworm-slim
#
#COPY --from=builder /app/app /app
#
#EXPOSE 3000
#
#ENTRYPOINT ["/app"]



# Этап сборки бинарника
# Этап сборки бинарника
#FROM golang:1.23.9 AS builder
#
#WORKDIR /app
#
#COPY go.mod ./
#COPY go.sum ./
#RUN go mod download
#
#COPY . .
#
## Кросс-компиляция для ARM64
#RUN GOARCH=arm64 GOOS=linux go build -o app main.go
#
## Финальный образ
#FROM debian:bookworm-slim
#
#COPY --from=builder /app/app /app
#
#EXPOSE 3000
#
#ENTRYPOINT ["/app"]


# Этап сборки (build stage)
FROM --platform=linux/arm64 golang:1.23.9 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Явно указываем сборку для arm64
RUN GOOS=linux GOARCH=arm64 go build -o app main.go

# Финальный образ (runtime)
FROM --platform=linux/arm64 debian:bookworm-slim

COPY --from=builder /app/app /app

EXPOSE 3000

ENTRYPOINT ["/app"]


