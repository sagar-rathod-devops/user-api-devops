# Stage 1: Build the Go binary
FROM golang:1.24.3-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o main

# Stage 2: Create a minimal runtime image
FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/main .

EXPOSE 8000

CMD ["./main"]
