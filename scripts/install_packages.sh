#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL BASE PACKAGES ==="

export DEBIAN_FRONTEND=noninteractive

sudo apt update -y

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

# fd (Ubuntu では fdfind になる場合の対応)
if ! command -v fd >/dev/null 2>&1; then
  if command -v fdfind >/dev/null 2>&1; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  fi
fi

# bash-preexec（冪等）
if [ ! -d "$HOME/.bash-preexec" ]; then
  git clone https://github.com/rcaloras/bash-preexec "$HOME/.bash-preexec"
else
  echo "bash-preexec already exists"
fi

echo "=== BASE PACKAGES INSTALLED ==="
