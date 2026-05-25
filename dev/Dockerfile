FROM h3xsh/image:base

USER root

# Node.js 24
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    node --version && \
    npm --version

RUN npm install -g yarn && \
    yarn --version

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

USER dev
WORKDIR /home/dev

CMD ["zsh"]
