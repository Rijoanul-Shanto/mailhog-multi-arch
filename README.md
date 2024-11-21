# 📬 Multi-Platform MailHog Docker Image 🚢

<div align="center">
  <img src="https://img.shields.io/docker/pulls/rijoanul/mailhog?style=for-the-badge&logo=docker&color=2496ED" alt="Docker Pulls">
  <img src="https://img.shields.io/docker/image-size/rijoanul/mailhog/latest?style=for-the-badge&logo=docker&color=2496ED" alt="Docker Image Size">
  <img src="https://img.shields.io/badge/architectures-amd64%20%7C%20arm64%20%7C%20armv8-blue?style=for-the-badge" alt="Supported Architectures">
</div>

## 🌟 Overview

MailHog is an easy-to-use, open-source email testing tool for developers. This Docker image provides a **hassle-free, multi-architecture solution** for running MailHog across different platforms.

### 🖥️ Supported Architectures
- `linux/amd64` (x86_64)
- `linux/arm64` (64-bit ARM)
- `linux/arm/v8` (32-bit ARM)

## 🚀 Quick Start

### 🐳 Docker Pull
```bash
docker pull rijoanul/mailhog:latest
```

### 🏃 Docker Run
```bash
docker run -d \
  --name mailhog \
  -p 1025:1025 \
  -p 8025:8025 \
  rijoanul/mailhog:latest
```

## 🔧 Ports
- **SMTP Server**: 1025
- **Web UI**: 8025

## 💡 Usage Scenarios

### 📧 Local Development
Perfect for:
- Testing email sending functionality
- Capturing and inspecting outgoing emails
- Debugging email-related features

### 🛠️ Continuous Integration
- Easily integrate email testing in CI/CD pipelines
- Works consistently across different hardware architectures

## 🔒 Security
- Runs as non-root user (`mailhog`)
- Minimal Alpine Linux base image
- Lightweight and secure

## 📦 Image Variants

| Tag | Description |
|-----|-------------|
| `latest` | Most recent stable version |
| `v1.0.0` | Specific version pinning |

## 🤝 Contributing
Contributions, issues, and feature requests are welcome!

## 📄 License
Distributed under the MIT License.

## 🌍 Connect
[@rijoanul](https://github.com/Rijoanul-Shanto)