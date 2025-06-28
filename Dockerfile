# Сборочный этап
FROM golang:1.24.2 AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o parcel-tracker

# Финальный минимальный образ
FROM debian:bullseye-slim

WORKDIR /app

COPY --from=builder /app/parcel-tracker .

CMD ["./parcel-tracker"]
