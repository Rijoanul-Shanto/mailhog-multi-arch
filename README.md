# Multi-Platform Mailhog Docker Image

## Overview
A multi-architecture (amd64, arm64, armv7) Docker image for Mailhog.

## Installation

### Docker Pull
```bash
docker pull yourusername/mailhog:latest
```

### Docker Run
```bash
docker run -d \
  -p 1025:1025 \
  -p 8025:8025 \
  yourusername/mailhog:latest
```