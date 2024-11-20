FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git build-base

# Set working directory
WORKDIR /app

# Install MailHog
RUN GOARCH=$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/') \
    go install github.com/mailhog/MailHog@latest

FROM alpine:latest

# Add runtime dependencies
RUN apk add --no-cache ca-certificates

# Copy MailHog binary
COPY --from=builder /go/bin/MailHog /usr/local/bin/mailhog

# Metadata
LABEL maintainer="Your Name <your.email@example.com>"
LABEL org.opencontainers.image.source="https://github.com/yourusername/mailhog-docker"
LABEL org.opencontainers.image.description="Multi-platform Mailhog Docker Image"

EXPOSE 1025 8025

ENTRYPOINT ["/usr/local/bin/mailhog"]