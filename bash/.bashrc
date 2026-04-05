# ~/.bashrc

# インタラクティブシェルでなければ終了
[[ $- != *i* ]] && return

# --- 設定ファイルの読み込み ---
BASH_CONFIG_DIR="$HOME/.config/bash"

for f in exports aliases; do
    [ -f "$BASH_CONFIG_DIR/$f.sh" ] && source "$BASH_CONFIG_DIR/$f.sh"
done

# --- WSL専用設定 ---
source "$HOME/dotfiles/scripts/detect_os.sh"
if is_wsl; then
    [ -f "$BASH_CONFIG_DIR/wsl.sh" ] && source "$BASH_CONFIG_DIR/wsl.sh"
fi

# --- プロンプト ---
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
