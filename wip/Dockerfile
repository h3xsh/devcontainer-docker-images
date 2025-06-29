FROM h3xsh/image:base

USER root

ENV GO_VERSION=1.24.1

RUN wget -q https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin
    
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/pkg" "$GOPATH/pkg/mod" \
    && chown -R dev:dev "$GOPATH"

RUN go version

# pre-install vscode-server
ENV VSCODE_INSTALL_PREFIX="/opt/vscode-web"

RUN mkdir -p "${VSCODE_INSTALL_PREFIX}" \
    && chown -R dev:dev "${VSCODE_INSTALL_PREFIX}"

RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
        x86_64) ARCH="x64" ;; \
        aarch64) ARCH="arm64" ;; \
        *) echo "Unsupported architecture" && exit 1 ;; \
    esac && \
    DETECTED_PLATFORM="linux" && \
    HASH=$(curl -fsSL https://update.code.visualstudio.com/api/commits/stable/server-$DETECTED_PLATFORM-$ARCH-web | cut -d '"' -f 2) && \
    echo "Installing VS Code Web commit: $HASH" && \
    curl -fsSL "https://vscode.download.prss.microsoft.com/dbazure/download/stable/$HASH/vscode-server-$DETECTED_PLATFORM-$ARCH-web.tar.gz" | \
    tar -xz -C "${VSCODE_INSTALL_PREFIX}" --strip-components 1

ENV VSCODE_WEB="${VSCODE_INSTALL_PREFIX}/bin/code-server"

# Note: Extensions will be installed in /workspaces/.vscode-server/extensions (persistent storage)
# We only pre-install VS Code Server itself, not extensions

# Create default settings template that will be copied to persistent storage
RUN mkdir -p /opt/vscode-settings-template
COPY vscode/settings.json /opt/vscode-settings-template/settings.json
COPY vscode/init-vscode.sh /opt/init-vscode.sh
RUN chmod +x /opt/init-vscode.sh

USER dev
WORKDIR /home/dev

CMD ["zsh"]