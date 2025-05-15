FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    git \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    sudo \
    iputils-ping \
    whois \
    dnsutils \
    openssh-client \
    gnupg \
    curl \
    wget \
    procps \
    jq \
    vim \
    nano \
    traceroute \
    net-tools \
    ca-certificates \
    tree \
    make \
    python3 \
    python-is-python3 \
    python3-pip \
    pipx \
    unzip \
    apt-transport-https \
    && mkdir -p /etc/apt/keyrings \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1337 dev && \
    useradd -u 1337 -g 1337 -m -s /usr/bin/zsh -G sudo dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev

RUN mkdir -p /home/dev && chown -R dev:dev /home/dev
RUN mkdir -p /home/dev/scripts && chown -R dev:dev /home/dev/scripts

# Set up .zshrc for both root and dev user
COPY .zshrc /root/.zshrc
COPY .zshrc /home/dev/.zshrc
COPY scripts/git-set-config.sh /home/dev/scripts/git-set-config.sh

# Fix permissions
RUN chown dev:dev /home/dev/.zshrc
RUN chown dev:dev /home/dev/scripts/git-set-config.sh

# Set zsh as default shell for root
RUN chsh -s /usr/bin/zsh

USER dev
WORKDIR /home/dev

CMD ["zsh"]