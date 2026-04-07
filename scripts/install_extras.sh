#!/usr/bin/env bash
# 標準aptリポジトリ外のツールをインストール

set -euo pipefail

# --- Neovim (apt版は古いため GitHub リリースから最新版を入れる) ---
install_neovim() {
    local current_ver major minor
    current_ver=$(nvim --version 2>/dev/null | head -1 | grep -oP '\d+\.\d+' | head -1)
    major=$(echo "${current_ver:-0.0}" | cut -d. -f1)
    minor=$(echo "${current_ver:-0.0}" | cut -d. -f2)
    if [ "${major:-0}" -ge 1 ] || [ "${minor:-0}" -ge 10 ]; then
        echo "    neovim: already 0.10+ (${current_ver})"
        return
    fi
    echo "    Installing neovim 0.10+ from GitHub releases..."
    local archive="nvim-linux-x86_64.tar.gz"
    curl -fsSLO "https://github.com/neovim/neovim/releases/latest/download/${archive}"
    sudo tar -C /opt -xzf "${archive}"
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    rm -f "${archive}"
    echo "    neovim: $(nvim --version | head -1)"
}

# --- gh (GitHub CLI) ---
install_gh() {
    if command -v gh &>/dev/null; then
        echo "    gh: already installed"
        return
    fi
    echo "    Installing gh (GitHub CLI)..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update -q
    sudo apt install -y gh
}

# --- eza ---
install_eza() {
    if command -v eza &>/dev/null; then
        echo "    eza: already installed"
        return
    fi
    echo "    Installing eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
        | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
        | sudo tee /etc/apt/sources.list.d/gierens.list > /dev/null
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update -q
    sudo apt install -y eza
}

# --- zoxide ---
install_zoxide() {
    if command -v zoxide &>/dev/null; then
        echo "    zoxide: already installed"
        return
    fi
    echo "    Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

echo "==> Installing extra tools (neovim 0.10+, gh, eza, zoxide)..."
install_neovim
install_gh
install_eza
install_zoxide
echo "==> Extra tools installed."
