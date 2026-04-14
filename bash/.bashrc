# ~/.bashrc

# インタラクティブシェルでなければ終了
[[ $- != *i* ]] && return

# --- bash オプション ---
shopt -s histappend     # 複数端末で履歴を上書きせず追記
shopt -s cdspell        # cd のスペルミスを自動修正
shopt -s autocd         # ディレクトリ名だけで cd
shopt -s globstar       # ** でサブディレクトリを再帰マッチ
shopt -s checkwinsize   # ウィンドウサイズ変更を反映

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

# --- fzf キーバインド (CTRL-R, CTRL-T, ALT-C) ---
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && \
    source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/bash-completion/completions/fzf ] && \
    source /usr/share/bash-completion/completions/fzf

# --- プロンプト (starship があれば使う、なければフォールバック) ---
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
fi

. "$HOME/.local/bin/env"
