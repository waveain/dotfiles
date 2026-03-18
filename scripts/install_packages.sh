#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL BASE PACKAGES ==="

export DEBIAN_FRONTEND=noninteractive

# -------------------------------
# apt update（必要最低限）
# -------------------------------
sudo apt update -y

# -------------------------------
# 基本パッケージ
# -------------------------------
PACKAGES=(
  build-essential
  git
  curl
  wget
  ripgrep
  fd-find
  fzf
  tmux
  unzip
  pkg-config
  libssl-dev
  btop
  direnv
  git-delta
  tree
  ca-certificates
  gnupg
  lsb-release
  software-properties-common
)

sudo apt install -y "${PACKAGES[@]}"

# -------------------------------
# fd (Ubuntu対策)
# -------------------------------
if ! command -v fd >/dev/null 2>&1; then
  if command -v fdfind >/dev/null 2>&1; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"

    # PATH追加（重複防止）
    if ! grep -q '.local/bin' "$HOME/.bashrc" 2>/dev/null; then
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
  fi
fi

# -------------------------------
# bash-preexec（冪等）
# -------------------------------
if [ ! -d "$HOME/.bash-preexec" ]; then
  git clone https://github.com/rcaloras/bash-preexec "$HOME/.bash-preexec"
else
  echo "bash-preexec already exists"
fi

echo "=== BASE PACKAGES INSTALLED ==="