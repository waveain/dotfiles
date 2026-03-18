#!/usr/bin/env bash
set -euo pipefail

echo "=== START SETUP ==="

# -------------------------------
# 基本パッケージ
# -------------------------------
echo "[1/9] install packages"
bash scripts/install_packages.sh

# -------------------------------
# Rust
# -------------------------------
echo "[2/9] install rust"
bash scripts/install_rust.sh

if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi

# -------------------------------
# Rust tools
# -------------------------------
echo "[3/9] install rust tools"
bash scripts/install_rust_tools.sh

# -------------------------------
# Neovim
# -------------------------------
echo "[4/9] install neovim"
bash scripts/install_neovim.sh

# -------------------------------
# Starship
# -------------------------------
echo "[5/9] install starship"
bash scripts/install_starship.sh

# -------------------------------
# Lazygit
# -------------------------------
echo "[6/9] install lazygit"
bash scripts/install_lazygit.sh

# -------------------------------
# Docker（WSL考慮）
# -------------------------------
echo "[7/9] install docker"

if grep -qi microsoft /proc/version; then
  echo "WSL detected"

  if command -v docker >/dev/null 2>&1; then
    echo "Docker already available (likely Docker Desktop)"
  else
    bash scripts/install_docker.sh
  fi
else
  bash scripts/install_docker.sh
fi

# -------------------------------
# Git設定
# -------------------------------
echo "[8/9] setup git"
bash scripts/setup_git.sh

# -------------------------------
# 設定リンク
# -------------------------------
echo "[9/9] link config"
bash scripts/link_config.sh

echo "=== SETUP COMPLETE ==="