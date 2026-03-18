#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL STARSHIP ==="

# -------------------------------
# PATH確認
# -------------------------------
if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
  echo "Warning: /usr/local/bin not in PATH"
fi

# -------------------------------
# インストール / 更新
# -------------------------------
if command -v starship >/dev/null 2>&1; then
  echo "starship already installed → updating"
else
  echo "installing starship"
fi

# curl強化 + インストール先指定
curl --proto '=https' --tlsv1.2 -fsSL https://starship.rs/install.sh \
  | sh -s -- -y --bin-dir /usr/local/bin

echo "=== STARSHIP INSTALLED ==="