#!/usr/bin/env bash
set -euo pipefail

echo "=== INSTALL DOCKER ==="

# -------------------------------
# WSLチェック
# -------------------------------
if grep -qi microsoft /proc/version; then
  echo "WSL detected"

  if command -v docker >/dev/null 2>&1; then
    echo "Docker already available (Docker Desktop?)"
    exit 0
  fi
fi

# -------------------------------
# 既存dockerチェック
# -------------------------------
if command -v docker >/dev/null 2>&1; then
  echo "Docker already installed"
  exit 0
fi

# -------------------------------
# 古いdocker削除
# -------------------------------
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# -------------------------------
# 必要パッケージ
# -------------------------------
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# -------------------------------
# GPGキー（冪等）
# -------------------------------
if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
else
  echo "Docker GPG key already exists"
fi

# -------------------------------
# リポジトリ（冪等）
# -------------------------------
DOCKER_LIST="/etc/apt/sources.list.d/docker.list"

if [ ! -f "$DOCKER_LIST" ]; then
  echo \
    "deb [arch=$(dpkg --print-architecture) \
    signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
    | sudo tee "$DOCKER_LIST" > /dev/null
else
  echo "Docker repo already exists"
fi

# -------------------------------
# インストール
# -------------------------------
sudo apt update
sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# -------------------------------
# dockerグループ
# -------------------------------
if ! groups "$USER" | grep -q docker; then
  sudo usermod -aG docker "$USER"
  echo "Added $USER to docker group"
else
  echo "User already in docker group"
fi

echo "=== DOCKER INSTALLED ==="
echo "※ 再ログイン or 'newgrp docker' を実行してください"