#!/usr/bin/env bash
# Set up SSH key for GitHub.

set -euo pipefail

KEY_NAME="${1:-id_ed25519}"
KEY_PATH="$HOME/.ssh/$KEY_NAME"

if [ -f "$KEY_PATH" ]; then
    echo "==> SSH key already exists: $KEY_PATH"
    echo ""
    echo "==> Testing connection to GitHub..."
    ssh_output=$(ssh -T git@github.com -o StrictHostKeyChecking=accept-new 2>&1) || true
    if echo "$ssh_output" | grep -q "successfully authenticated"; then
        echo "==> Already connected to GitHub. Nothing to do."
        exit 0
    else
        echo "==> Not yet registered with GitHub."
        echo "==> Add the following public key to GitHub:"
        echo "    https://github.com/settings/ssh/new"
        echo ""
        cat "${KEY_PATH}.pub"
    fi
else
    read -rp "==> No SSH key found. Generate a new one? [y/N] " answer
    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
        echo "==> Skipped."
        exit 0
    fi
    read -rp "Enter your email for the SSH key: " email
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    ssh-keygen -t ed25519 -C "$email" -f "$KEY_PATH" -N ""
    echo "==> SSH key generated: $KEY_PATH"
    echo ""
    echo "==> Add the following public key to GitHub:"
    echo "    https://github.com/settings/ssh/new"
    echo ""
    cat "${KEY_PATH}.pub"
fi
