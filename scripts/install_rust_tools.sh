#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL RUST TOOLS ==="

if ! command -v cargo >/dev/null 2>&1; then
  echo "Rust is not installed. Please run install_rust.sh first."
  exit 1
fi

# crate名:コマンド名 の形式で定義
TOOLS=(
  "atuin:atuin"
  "zoxide:zoxide"
  "eza:eza"
  "bat:bat"
)

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
