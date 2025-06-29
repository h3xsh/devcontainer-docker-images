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