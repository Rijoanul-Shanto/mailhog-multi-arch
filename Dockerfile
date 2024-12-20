FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git build-base ca-certificates

# Set working directory
WORKDIR /app

# Clone MailHog repository
RUN git clone https://github.com/mailhog/MailHog.git .

# Initialize Go module and download dependencies
RUN go mod init mailhog \
    && go mod tidy \
    && go mod vendor

# Debug architecture variables
RUN echo "TARGETARCH: $TARGETARCH"

# Build the application with explicit architecture
RUN CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=$(echo ${TARGETARCH:-amd64} | sed 's/arm64v8/arm64/; s/amd64/amd64/; s/arm\/v8/arm/') \
    go build -mod=vendor -o mailhog

FROM alpine:latest

# Add runtime dependencies
RUN apk add --no-cache ca-certificates

# Copy MailHog binary
COPY --from=builder /app/mailhog /usr/local/bin/mailhog

# Metadata
LABEL maintainer="Rijoanul Hasan <rijoanul.shanto@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Rijoanul-Shanto/mailhog-multi-arch"
LABEL org.opencontainers.image.description="Multi-platform Mailhog Docker Image"

EXPOSE 1025 8025

ENTRYPOINT ["/usr/local/bin/mailhog"]