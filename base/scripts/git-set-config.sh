#!/bin/bash
# ~/scripts/git-set-config.sh

git-set-config() {
    local email="$1"
    local name="$2"
    local ssh_key="$3"
    
    # If required parameters are missing, show usage
    if [ -z "$email" ] || [ -z "$name" ]; then
        echo "Usage: git-set-config <email> <name> [ssh_key_path]"
        echo "Example: git-set-config 'user@example.com' 'First Last' ~/.ssh/github_e1d0.pub"
        return 1
    fi
    
    # Set user name and email
    git config user.name "$name"
    git config user.email "$email"
    echo "Git config set for user $name ($email) in current repository."
    
    # Configure SSH signing
    git config gpg.format ssh
    
    if [ -n "$ssh_key" ]; then
        git config user.signingkey "$ssh_key"
        echo "SSH signing key set to $ssh_key"
    else
        # Default to id_ed25519.pub if no key specified
        git config user.signingkey ~/.ssh/id_ed25519.pub
        echo "SSH signing key set to ~/.ssh/id_ed25519.pub (default)"
    fi
    
    git config commit.gpgsign true
    git config tag.gpgsign true
    echo "SSH commit and tag signing enabled."
    
    # Set some recommended Git configurations
    git config core.editor "vim"
    git config core.autocrlf input
    git config pull.rebase true
    git config fetch.prune true
    git config rebase.autoStash true
    git config color.ui true
    git config core.ignorecase false
    echo "Additional Git configurations set."
}