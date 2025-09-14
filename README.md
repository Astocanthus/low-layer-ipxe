# iPXE Server Docker

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)
[![Alpine Linux](https://img.shields.io/badge/Alpine_Linux-0D597F?style=for-the-badge&logo=alpine-linux&logoColor=white)](https://alpinelinux.org/)
[![Fedora CoreOS](https://img.shields.io/badge/Fedora_CoreOS-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://fedoraproject.org/coreos/)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/release/Astocanthus/low-layer-vault.svg)](https://github.com/Astocanthus/low-layer-vault/releases)
[![GitHub issues](https://img.shields.io/github/issues/Astocanthus/low-layer-vault.svg)](https://github.com/Astocanthus/low-layer-vault/issues)
[![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen.svg)](https://github.com)
[![Security](https://img.shields.io/badge/Security-HTTP%20Basic%20Auth-green.svg)](https://github.com)

A containerized iPXE server built with Nginx for serving system images and Ignition configuration files.

## Features

- **HTTP Basic Authentication** with configurable credentials
- **System Images Serving** - Host and serve OS images (IMG)
- **Ignition Configuration** - Serve Ignition files with proper content types
- **Auto-indexing** - Browse files through web interface
- **Security Headers** - Built-in security configurations
- **Lightweight** - Based on Alpine Linux

## Quick Start

### Using Docker Compose

```yaml
docker-compose up -d .
```

### Using Docker Run

```bash
docker build -t ipxe-server .
docker run -d \
  -p 80:80 \
  -e IPXE_USER=admin \
  -e IPXE_PASSWORD=your-secure-password \
  -v ./images:/var/www/images \
  -v ./ignition:/var/www/ignition \
  -v ./auth:/etc/nginx/auth
  ipxe-server
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `IPXE_USER` | `admin` | HTTP Basic Auth username |
| `IPXE_PASSWORD` | `changeme` | HTTP Basic Auth password |

## Directory Structure

```
├── auth/                # Auto-generated .htpasswd files
├── build/
│   ├── Dockerfile       # Docker image build code
│   ├── nginx.conf       # Main Nginx configuration
│   ├── default.conf     # Virtual host configuration
│   └── init.sh          # Initialization script
├── ignition             # Ignition configuration files
├── images               # System images
│   ├── fcos/            # FedoraCoreos System images (initramfs, kernel, rootfs)
├── docker-compose.yml
└── .env                 # Environment variables
```

## Endpoints

- **`/`** - Server status page
- **`/images/`** - Browse and download system images
- **`/ignition/`** - Browse and download Ignition files

## Usage

1. **Start the container** with your preferred method
2. **Add system images** to the `images/` directory
3. **Add Ignition configs** to the `ignition/` directory
4. **Access the server** at `http://your-server/`

### Adding Fedora CoreOS Images

Drop your Fedora CoreOS system images in the `images/` directory:

```bash
# Example structure
images/
├── fedora-coreos-38.20230918.3.0-live-kernel-x86_64
├── fedora-coreos-38.20230918.3.0-live-initramfs.x86_64.img
└── fedora-coreos-38.20230918.3.0-live-rootfs.x86_64.img
```

### Adding Ignition Configuration

Place your Ignition configuration files in the `ignition/` directory:

```bash
ignition/
├── default.ign
├── master.ign
└── worker.ign
```

## Security Features

- HTTP Basic Authentication for all endpoints
- Security headers (X-Frame-Options, X-Content-Type-Options, X-XSS-Protection)
- Hidden files and .htpasswd protection
- Server tokens disabled

## Development

### Building

```bash
docker build -t ipxe-server .
```

### Testing

```bash
# Test server status
curl -u admin:your-password http://<ip of fqdn>/

# List images
curl -u admin:your-password http://<ip of fqdn>/images/

# List Ignition files
curl -u admin:your-password http://<ip of fqdn>/ignition/
```

## Configuration

The server uses Nginx with optimized settings for serving large files:

- Sendfile enabled for efficient file serving
- Proper caching headers for images (1 hour)
- No-cache headers for Ignition files
- Auto-indexing with human-readable file sizes

## License

This project is open source and available under the MIT License.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request