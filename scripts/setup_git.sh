#!/usr/bin/env bash
set -euo pipefail

echo "=== Git initial setup ==="

CURRENT_NAME=$(git config --global user.name || true)
if [ -n "$CURRENT_NAME" ]; then
  echo "Current user.name: $CURRENT_NAME"
else
  read -rp "Git user.name: " GIT_NAME
  if [ -n "$GIT_NAME" ]; then
    git config --global user.name "$GIT_NAME"
  fi
fi

CURRENT_EMAIL=$(git config --global user.email || true)
if [ -n "$CURRENT_EMAIL" ]; then
  echo "Current user.email: $CURRENT_EMAIL"
else
  read -rp "Git user.email: " GIT_EMAIL
  if [ -n "$GIT_EMAIL" ]; then
    git config --global user.email "$GIT_EMAIL"
  fi
fi

git config --global init.defaultBranch main
git config --global color.ui auto
git config --global pull.rebase false
git config --global push.default simple

if command -v nvim >/dev/null 2>&1; then
  git config --global core.editor "nvim"
else
  git config --global core.editor "vim"
fi

if command -v delta >/dev/null 2>&1; then
  git config --global core.pager "delta"
  git config --global interactive.diffFilter "delta --color-only"
  git config --global delta.navigate true
fi

# 改行コード（WSL対策）
if grep -qi microsoft /proc/version; then
  git config --global core.autocrlf input
fi

echo "=== Git configured successfully ==="
