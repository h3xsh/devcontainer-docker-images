# Docker Images

These are my personal collection of devcontainers Docker images for various programming languages and tools I use on a regular basis. 

⚠️ **Local dev only** - these images intended for local development environments only. They may change frequently and are not guaranteed to be stable. Stuff might break/change without warning.

## Base Image
`h3xsh/image:base` - Debian bookworm-slim based development environment with git, curl, wget, vim, nano, zsh, network utilities, Apache Bench.

## Node Images *LTS*
- `h3xsh/image:nodejs-20` - Node.js 20
- `h3xsh/image:nodejs-22` - Node.js 22

## Go latest (1.24.1)
- `h3xsh/image:go` - go 1.24.1

## PHP latest (8.4.5 + composers 2.8.8)
- `h3xsh/image:php-84` - php 8.4 + composer 2.8.8

## WIP/Experimental
- `h3xsh/image:wip` - Testing and experimental builds (unstable)

## Folder Structure
```
base/      # Base image
nodejs-20/ # Node.js 20 image
nodejs-22/ # Node.js 22 image
go/        # go 1.24.1 image
php-84/    # php 8.4 + composer
wip/       # experimental builds
```

## Usage
```bash
# Build
cd base && docker build -t h3xsh/image:base .
cd nodejs-20 && docker build -t h3xsh/image:nodejs-20 .
cd nodejs-22 && docker build -t h3xsh/image:nodejs-22 .
cd go && docker build -t h3xsh/image:go .
cd php-84 && docker build -t h3xsh/image:php-84 .
cd wip && docker build -t h3xsh/image:wip .

# Run
docker run -it --rm h3xsh/image:wip
```

## Features
- ZSH shell with plugins
- Dev user (uid 1337) with sudo (no password)
- Common development tools


## VS Code Server License Notice
These images include VS Code Server. **By using these images, you agree to comply with Microsoft's VS Code Server license terms:**
- Full license: https://code.visualstudio.com/license/server
- Documentation: https://code.visualstudio.com/docs/remote/vscode-server

**Important:** If you redistribute these images or use them in violation of Microsoft's terms, you do so at your own risk and responsibility, or fork the repository and strip them if you prefer so.

## Other License Information
- images and custom code: MIT License (see LICENSE file)
- Third-party components may have separate licenses
