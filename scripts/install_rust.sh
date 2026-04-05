#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL RUST ==="

if ! command -v rustup >/dev/null 2>&1; then
  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs \
    | sh -s -- -y
else
  echo "rustup already installed → updating"
  rustup self update
fi

if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi

rustup update
rustup default stable
rustup component add rustfmt clippy rust-analyzer

echo "=== RUST INSTALLED ==="
