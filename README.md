# Docker Images

## Base Image
`h3xsh/image:base` - Debian bookworm-slim based development environment with git, curl, wget, vim, nano, zsh, network utilities.

## Node Images *LTS*
- `h3xsh/image:nodejs-20` - Node.js 20 
- `h3xsh/image:nodejs-22` - Node.js 22

## Go latest (1.24.1)
- `h3xsh/image:go`        - go 1.24.1

## PHP latest (8.4.5 + composers 2.8.8)
- `h3xsh/image:php-84`    - php 8.4 + composer 2.8.8

## Folder Structure
```
base/             # Base image
nodejs-20/        # Node.js 20 image
nodejs-22/        # Node.js 22 image
go/               # go 1.24.1 image
php-84/           # php 8.4 + composer
```

## Usage
```bash
# Build
cd base
docker build -t h3xsh/image:base .

cd nodejs-20
docker build -t h3xsh/image:nodejs-20 .

cd nodejs-22
docker build -t h3xsh/image:nodejs-22 .

cd go
docker build -t h3xsh/image:go .

cd php-84
docker build -t h3xsh/image:php-84 .

# Run
docker run -it --rm h3xsh/image:nodejs-20
```

## Features
- ZSH shell with plugins
- Dev user (uid 1337) with sudo (`no password`)
- Common development tools
