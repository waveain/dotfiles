#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL RUST ==="

# -------------------------------
# rustupチェック
# -------------------------------
if ! command -v rustup >/dev/null 2>&1; then
  echo "Installing rustup..."

  curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs \
    | sh -s -- -y
else
  echo "rustup already installed → updating"
  rustup self update
fi

# -------------------------------
# 環境読み込み
# -------------------------------
if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi

# -------------------------------
# toolchain更新
# -------------------------------
rustup update

# -------------------------------
# デフォルトツールチェーン
# -------------------------------
rustup default stable

# -------------------------------
# 追加コンポーネント
# -------------------------------
rustup component add \
  rustfmt \
  clippy \
  rust-analyzer

echo "=== RUST INSTALLED ==="