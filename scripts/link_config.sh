#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/dotfiles"

echo "=== LINK CONFIG START ==="

# -------------------------------
# WSL 設定（WSLのみ）
# -------------------------------
if grep -qi microsoft /proc/version; then
  echo "[WSL] linking wsl.conf"
  sudo ln -sf "${DOTFILES_DIR}/config/wsl/wsl.conf" /etc/wsl.conf
fi

# -------------------------------
# Neovim
# -------------------------------
echo "[nvim]"
mkdir -p "$HOME/.config/nvim"
ln -sf "${DOTFILES_DIR}/config/nvim/init.lua" \
       "$HOME/.config/nvim/init.lua"

# -------------------------------
# tmux
# -------------------------------
echo "[tmux]"
ln -sf "${DOTFILES_DIR}/config/tmux/tmux.conf" \
       "$HOME/.tmux.conf"

# -------------------------------
# bash
# -------------------------------
echo "[bash]"

if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
  echo "backup existing .bashrc -> .bashrc.backup"
  mv "$HOME/.bashrc" "$HOME/.bashrc.backup"
fi

ln -sf "${DOTFILES_DIR}/config/bash/.bashrc" \
       "$HOME/.bashrc"

# -------------------------------
# starship
# -------------------------------
echo "[starship]"
mkdir -p "$HOME/.config/starship"
ln -sf "${DOTFILES_DIR}/config/starship/starship.toml" \
       "$HOME/.config/starship/starship.toml"

# -------------------------------
# gitconfig
# -------------------------------
echo "[git]"

if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
  echo "backup existing .gitconfig -> .gitconfig.backup"
  cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup"
fi

ln -sf "${DOTFILES_DIR}/config/git/.gitconfig" \
       "$HOME/.gitconfig"

echo "=== LINK CONFIG DONE ==="
