# 環境変数

export EDITOR="nvim"
export VISUAL="nvim"

# ヒストリ設定
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth  # 重複・空白始まりを除外

# --- fzf ---
if command -v fzf &>/dev/null; then
    # bat があればプレビューに使う
    if command -v batcat &>/dev/null; then
        export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --preview 'batcat --color=always --line-range=:50 {}' --preview-window=right:50%:wrap"
    elif command -v bat &>/dev/null; then
        export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --preview 'bat --color=always --line-range=:50 {}' --preview-window=right:50%:wrap"
    else
        export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
    fi
    # ripgrep があればファイル検索に使う
    command -v rg &>/dev/null && export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
fi

# --- mise (dev tools version manager) ---
if command -v mise &>/dev/null; then
    eval "$(mise activate bash)"
elif [ -f "$HOME/.local/bin/mise" ]; then
    eval "$("$HOME/.local/bin/mise" activate bash)"
fi

# --- zoxide (cd の賢い代替) ---
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"

# ローカル設定（APIキー等、gitignore対象）
[ -f "$HOME/.config/bash/exports.local.sh" ] && source "$HOME/.config/bash/exports.local.sh"
