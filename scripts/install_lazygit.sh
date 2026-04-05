#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL LAZYGIT ==="

if command -v lazygit >/dev/null 2>&1; then
  echo "lazygit already installed"
  exit 0
fi

ARCH=$(uname -m)
case "$ARCH" in
  x86_64)  ARCH="x86_64" ;;
  aarch64 | arm64) ARCH="arm64" ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

LAZYGIT_VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
  | grep '"tag_name":' \
  | sed -E 's/.*"v([^"]+)".*/\1/')

if [ -z "$LAZYGIT_VERSION" ]; then
  echo "Failed to fetch latest version"
  exit 1
fi

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

curl -fLo lazygit.tar.gz \
  "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${ARCH}.tar.gz"

tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

cd -
rm -rf "$TMP_DIR"

echo "=== LAZYGIT INSTALLED ==="
