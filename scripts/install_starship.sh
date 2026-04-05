#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL STARSHIP ==="

if command -v starship >/dev/null 2>&1; then
  echo "starship already installed → updating"
else
  echo "installing starship"
fi

curl --proto '=https' --tlsv1.2 -fsSL https://starship.rs/install.sh \
  | sh -s -- -y --bin-dir /usr/local/bin

echo "=== STARSHIP INSTALLED ==="
