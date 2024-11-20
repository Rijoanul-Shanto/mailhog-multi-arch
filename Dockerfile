FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git build-base

# Set working directory
WORKDIR /app

# Clone MailHog repository
RUN git clone https://github.com/mailhog/MailHog.git .

# Initialize Go module and download dependencies
RUN go mod init mailhog \
    && go mod tidy

RUN echo "Building for TARGETPLATFORM: $TARGETPLATFORM" \
    && echo "TARGETOS: $TARGETOS" \
    && echo "TARGETARCH: $TARGETARCH"

# Build the application with explicit architecture
RUN CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=$(echo $TARGETARCH | sed 's/arm64v8/arm64/; s/amd64/amd64/; s/arm\/v7/arm/') \
    go build -o mailhog

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