FROM h3xsh/image:base

USER root

ENV GO_VERSION=1.25.5

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