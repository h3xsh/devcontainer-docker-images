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
RUN mkdir -p /opt/vscode-settings-template && \
    cat > /opt/vscode-settings-template/settings.json << 'EOF'
{
    "workbench.colorTheme": "tvdotdev-dark",
    "workbench.startupEditor": "none",
    "window.dialogStyle": "custom",
    "editor.formatOnSave": true,
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 100,
    "terminal.integrated.defaultProfile.linux": "zsh",
    "terminal.integrated.copyOnSelection": true,
    "terminal.integrated.enableMultiLinePasteWarning": false,
    "terminal.integrated.defaultLocation": "view",
    "terminal.integrated.sendKeybindingsToShell": true,
    "security.workspace.trust.enabled": false,
    "security.workspace.trust.startupPrompt": "never",
    "security.workspace.trust.untrustedFiles": "open",
    "security.workspace.trust.banner": "never",
    "security.workspace.trust.emptyWindow": false,
    "security.workspace.trust.folderTrustEnabled": false,
    "security.workspace.trust.trustedFolders": ["/workspaces"],
    "explorer.confirmDelete": false,
    "explorer.confirmDragAndDrop": false,
    "update.showReleaseNotes": false,
    "telemetry.telemetryLevel": "off",
    "workbench.editor.untitled.hint": "hidden",
    "window.restoreWindows": "none",
    "editor.minimap.enabled": true,
    "editor.minimap.renderCharacters": false,
    "editor.minimap.maxColumn": 80,
    "editor.minimap.showSlider": "mouseover",
    "editor.renderWhitespace": "boundary",
    "editor.cursorBlinking": "expand",
    "editor.smoothScrolling": true,
    "editor.rulers": [80, 120],
    "editor.bracketPairColorization.enabled": true,
    "editor.guides.bracketPairs": "active",
    "editor.stickyScroll.enabled": true,
    "editor.linkedEditing": true,
    "editor.inlineSuggest.enabled": true,
    "editor.suggest.insertMode": "replace",
    "editor.formatOnType": true,
    "git.autofetch": true,
    "git.confirmSync": false,
    "git.enableSmartCommit": true,
    "explorer.autoReveal": true,
    "explorer.sortOrder": "type",
    "explorer.compactFolders": false,
    "search.showLineNumbers": true,
    "search.smartCase": true,
    "terminal.integrated.cursorStyle": "line",
    "terminal.integrated.fontSize": 14,
    "terminal.integrated.shellIntegration.enabled": true,
    "workbench.panel.defaultLocation": "bottom",
    "terminal.integrated.autoRevealOnStartup": true,
    "workbench.panel.opensMaximized": "never",
    "files.watcherExclude": {
        "**/.git/objects/**": true,
        "**/.git/subtree-cache/**": true,
        "**/node_modules/**": true,
        "**/.hg/store/**": true
    },
    "go.toolsManagement.autoUpdate": true,
    "go.useLanguageServer": true,
    "go.formatTool": "goimports",
    "go.lintTool": "golangci-lint",
    "go.testFlags": ["-v"],
    "go.coverOnSave": false,
    "go.coverOnSingleTest": true,
    "go.delveConfig": {
        "debugAdapter": "legacy",
        "apiVersion": 2,
        "maxStringLen": 64,
        "maxArrayValues": 64,
        "maxVariableRecurse": 1,
        "showGlobalVariables": false
    }
}
EOF

# Create startup script for VS Code initialization
RUN cat > /opt/init-vscode.sh << 'EOF'
#!/bin/bash
# Initialize VS Code settings and extensions in persistent storage

WORKSPACES_VSCODE_DIR="/workspaces/.vscode-server"
SETTINGS_DIR="${WORKSPACES_VSCODE_DIR}/data/Machine"
USER_DATA_DIR="${WORKSPACES_VSCODE_DIR}/data/User"
EXTENSIONS_DIR="${WORKSPACES_VSCODE_DIR}/extensions"

# Create directories if they don't exist
mkdir -p "${SETTINGS_DIR}" "${USER_DATA_DIR}" "${EXTENSIONS_DIR}"

# Copy default settings if they don't exist
if [ ! -f "${SETTINGS_DIR}/settings.json" ]; then
    echo "Initializing VS Code settings in persistent storage..."
    cp /opt/vscode-settings-template/settings.json "${SETTINGS_DIR}/settings.json"
fi

# Install Go extensions if not already installed
VSCODE_WEB="/opt/vscode-web/bin/code-server"
if [ -f "$VSCODE_WEB" ]; then
    echo "Installing/updating Go extensions in persistent storage..."
    
    # List of extensions to install
    extensions=(
        "golang.go"
        "h3xsh.h3xsh-vscode-theme"
        "eamodio.gitlens"
        "mhutchie.git-graph"
        "aaron-bond.better-comments"
        "visualstudioexptteam.vscodeintellicode"
    )
    
    for ext in "${extensions[@]}"; do
        if ! "$VSCODE_WEB" --extensions-dir="$EXTENSIONS_DIR" --list-extensions | grep -q "$ext"; then
            echo "Installing extension: $ext"
            "$VSCODE_WEB" --extensions-dir="$EXTENSIONS_DIR" --install-extension "$ext" --force
        else
            echo "Extension already installed: $ext"
        fi
    done
fi

# Set proper ownership
chown -R dev:dev "${WORKSPACES_VSCODE_DIR}"

echo "VS Code initialization complete in ${WORKSPACES_VSCODE_DIR}"
EOF

RUN chmod +x /opt/init-vscode.sh

USER dev
WORKDIR /home/dev

CMD ["zsh"]