#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL RUST TOOLS ==="

# -------------------------------
# cargoチェック
# -------------------------------
if ! command -v cargo >/dev/null 2>&1; then
  echo "Rust is not installed. Please run install_rust.sh first."
  exit 1
fi

# -------------------------------
# PATH確認
# -------------------------------
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
  echo "Warning: ~/.cargo/bin is not in PATH"
fi

# -------------------------------
# ツール定義（crate名:コマンド名）
# -------------------------------
TOOLS=(
  "atuin:atuin"
  "zoxide:zoxide"
  "eza:eza"
  "bat:bat"
)

# -------------------------------
# インストール
# -------------------------------
for entry in "${TOOLS[@]}"; do
  IFS=":" read -r crate cmd <<< "$entry"

  if command -v "$cmd" >/dev/null 2>&1; then
    echo "$cmd already installed → updating"
    cargo install --locked "$crate" --force
  else
    echo "installing $crate"
    cargo install --locked "$crate"
  fi
done

echo "=== RUST TOOLS INSTALLED ==="