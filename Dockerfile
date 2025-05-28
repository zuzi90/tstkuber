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
FROM --platform=linux/arm64 golang:1.23.9 AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

# Явно указываем архитектуру и ОС для кросс-компиляции под ARM64
RUN GOARCH=arm64 GOOS=linux go build -o app main.go

# Финальный образ
FROM --platform=linux/arm64 debian:bookworm-slim

# Копируем только скомпилированный бинарник
COPY --from=builder /app/app /app

# Открываем порт
EXPOSE 3000

# Запускаем бинарник
ENTRYPOINT ["/app"]

