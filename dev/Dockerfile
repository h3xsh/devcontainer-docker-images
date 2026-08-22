FROM h3xsh/image:base

USER root

# Bun
ENV BUN_INSTALL=/usr/local/bun
ENV PATH=$BUN_INSTALL/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://bun.sh/install | bash && \
    chown -R dev:dev "$BUN_INSTALL" && \
    bun --version

# Go
ENV GO_VERSION=1.26.3

RUN wget -q https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/pkg" "$GOPATH/pkg/mod" \
    && chown -R dev:dev "$GOPATH"

RUN go version

# add vscode-server
RUN mkdir -p /home/dev/.vscode-web \
    && curl -fsSL -L "https://update.code.visualstudio.com/latest/server-linux-x64-web/stable" -o /tmp/vscode-web.tar.gz \
    && tar -xzf /tmp/vscode-web.tar.gz -C /home/dev/.vscode-web --strip-components=1 \
    && rm -f /tmp/vscode-web.tar.gz \
    && chown -R dev:dev /home/dev/.vscode-web

USER dev
WORKDIR /home/dev

# add claude code
RUN curl -fsSL https://claude.ai/install.sh | bash

CMD ["zsh"]
