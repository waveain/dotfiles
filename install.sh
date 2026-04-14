#!/usr/bin/env bash
set -euo pipefail

# --- Root check ---
if [ "$(id -u)" -eq 0 ]; then
    echo "ERROR: Do not run this script as root. Run as your normal user." >&2
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$DOTFILES_DIR/scripts/detect_os.sh"

echo "==> Detected OS: $(detect_os)"

# --- Install packages ---
if is_ubuntu; then
    echo "==> Installing packages..."
    sudo apt update -q
    sudo apt install -y $(grep -v '^\s*#' "$DOTFILES_DIR/packages/apt.txt" | tr '\n' ' ')

    # --- Generate locale ---
    echo "==> Generating locale (en_US.UTF-8)..."
    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

    # --- Extra tools (gh, eza, zoxide) ---
    bash "$DOTFILES_DIR/scripts/install_extras.sh"
fi

# --- Back up conflicting files before stowing ---
backup_conflicts() {
    local dir="$1"
    local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
    # --simulate でコンフリクト対象ファイルを取得してバックアップ
    local conflicts
    conflicts=$(stow --target="$HOME" --simulate --restow "$dir" 2>&1 \
        | grep "existing target" \
        | sed 's/.*existing target is neither a link nor a directory: //' \
        | sort -u) || true
    for f in $conflicts; do
        mkdir -p "$backup_dir/$(dirname "$f")"
        mv "$HOME/$f" "$backup_dir/$f"
        echo "    backed up: ~/$f -> $backup_dir/$f"
    done
}

# --- Create symlinks (GNU Stow) ---
echo "==> Creating symlinks..."
cd "$DOTFILES_DIR"
for dir in bash git ssh nvim mise tmux starship editorconfig; do
    backup_conflicts "$dir"
    stow --target="$HOME" --restow "$dir"
    echo "    stow: $dir"
done

# --- Install mise tools ---
if command -v mise &>/dev/null; then
    echo "==> Installing mise tools..."
    mise install
fi

# --- WSL default user ---
if is_wsl; then
    echo "==> Configuring WSL default user..."
    CURRENT_USER="$(whoami)"
    WSL_CONF="/etc/wsl.conf"
    if grep -q '^\[user\]' "$WSL_CONF" 2>/dev/null; then
        # [user] セクションが既にある場合は default 行だけ更新
        sudo sed -i '/^\[user\]/,/^\[/{s/^default\s*=.*/default='"$CURRENT_USER"'/}' "$WSL_CONF"
        # default 行がなければ [user] セクション直後に追加
        if ! grep -q '^default=' "$WSL_CONF"; then
            sudo sed -i '/^\[user\]/a default='"$CURRENT_USER" "$WSL_CONF"
        fi
    else
        # [user] セクションがなければ末尾に追記
        printf '\n[user]\ndefault=%s\n' "$CURRENT_USER" | sudo tee -a "$WSL_CONF" > /dev/null
    fi
    echo "    /etc/wsl.conf: default user set to '$CURRENT_USER'"
    echo "    Run 'wsl --terminate <distro>' from PowerShell to apply"
fi

echo "==> Done!"
echo "    Reload your shell: source ~/.bashrc"
echo ""
echo "==> To set up SSH key for GitHub, run:"
echo "    bash $DOTFILES_DIR/scripts/setup_ssh.sh [KEY_NAME]"
echo ""
echo "    KEY_NAME: SSH key filename under ~/.ssh/ (default: id_ed25519)"
echo "    Example:  bash $DOTFILES_DIR/scripts/setup_ssh.sh id_ed25519_wsl"
