# 環境変数

export EDITOR="nvim"
export VISUAL="nvim"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ヒストリ設定
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth  # 重複・空白始まりを除外

# ローカル設定（APIキー等、gitignore対象）
[ -f "$HOME/.config/bash/exports.local.sh" ] && source "$HOME/.config/bash/exports.local.sh"
