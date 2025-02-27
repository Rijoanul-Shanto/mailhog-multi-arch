FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git build-base ca-certificates

# Set working directory
WORKDIR /app

# Clone MailHog repository
RUN git clone https://github.com/mailhog/MailHog.git .

# Use ARG for architecture - this will be passed by Docker buildx
ARG TARGETARCH
ARG TARGETVARIANT

# Build the application with proper architecture mapping
RUN BUILD_ARCH=$TARGETARCH && \
    if [ "$TARGETARCH" = "arm" ] && [ "$TARGETVARIANT" = "v8" ]; then \
      BUILD_ARCH="arm64"; \
    fi && \
    echo "Building for architecture: $BUILD_ARCH" && \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=$BUILD_ARCH \
    go build -o mailhog

FROM alpine:latest

# Add runtime dependencies
RUN apk add --no-cache ca-certificates

# Copy MailHog binary
COPY --from=builder /app/mailhog /usr/local/bin/mailhog

# Metadata
LABEL maintainer="Rijoanul Hasan <rijoanul.shanto@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Rijoanul-Shanto/mailhog-multi-arch"
LABEL org.opencontainers.image.description="Multi-platform Mailhog Docker Image"

# Expose SMTP and HTTP ports
EXPOSE 1025 8025

ENTRYPOINT ["/usr/local/bin/mailhog"]