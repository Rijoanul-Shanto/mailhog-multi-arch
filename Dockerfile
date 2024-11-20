FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git build-base

# Set working directory
WORKDIR /app

# Clone and build MailHog directly
RUN git clone https://github.com/mailhog/MailHog.git . \
    && CGO_ENABLED=0 GOOS=linux go build -o mailhog

FROM alpine:latest

# Add runtime dependencies
RUN apk add --no-cache ca-certificates

# Copy MailHog binary
COPY --from=builder /go/bin/MailHog /usr/local/bin/mailhog

# Metadata
LABEL maintainer="Rijoanul Hasan <rijoanul.shanto@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Rijoanul-Shanto/mailhog-multi-arch"
LABEL org.opencontainers.image.description="Multi-platform Mailhog Docker Image"

EXPOSE 1025 8025

ENTRYPOINT ["/usr/local/bin/mailhog"]