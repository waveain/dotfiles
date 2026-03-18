#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL NEOVIM ==="

# -------------------------------
# 既存チェック
# -------------------------------
if command -v nvim >/dev/null 2>&1; then
  echo "Neovim already installed → updating"
fi

# -------------------------------
# アーキテクチャ判定
# -------------------------------
ARCH=$(uname -m)
case "$ARCH" in
  x86_64) ARCH="x86_64" ;;
  aarch64 | arm64) ARCH="arm64" ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

# -------------------------------
# ダウンロード
# -------------------------------
TMP_DIR=$(mktemp -d)
pushd "$TMP_DIR" >/dev/null

URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${ARCH}.tar.gz"

echo "Downloading: $URL"

curl -fLO "$URL"

# -------------------------------
# 展開
# -------------------------------
tar xzf "nvim-linux-${ARCH}.tar.gz"

# -------------------------------
# インストール
# -------------------------------
sudo mkdir -p /opt

if [ -d /opt/nvim ]; then
  echo "Replacing existing /opt/nvim"
  sudo rm -rf /opt/nvim
fi

sudo mv "nvim-linux-${ARCH}" /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# -------------------------------
# cleanup
# -------------------------------
popd >/dev/null
rm -rf "$TMP_DIR"

echo "=== NEOVIM INSTALLED ==="