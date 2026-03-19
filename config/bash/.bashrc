# ~/.bashrc

# -------------------------------
# PATH（重複防止付き）
# -------------------------------
add_path() {
  case ":$PATH:" in
    *":$1:"*) ;; # すでに存在
    *) PATH="$1:$PATH" ;;
  esac
}

add_path "$HOME/.local/bin"
add_path "$HOME/.cargo/bin"
add_path "/usr/local/bin"

export PATH

# -------------------------------
# Rust 環境
# -------------------------------
if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi

# -------------------------------
# bash-preexec
# -------------------------------
if [ -f "$HOME/.bash-preexec/bash-preexec.sh" ]; then
  source "$HOME/.bash-preexec/bash-preexec.sh"
fi

# -------------------------------
# Shell ツール
# -------------------------------
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# -------------------------------
# Starship（最後）
# -------------------------------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# -------------------------------
# fdfind対応（保険）
# -------------------------------
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

# -------------------------------
# history
# -------------------------------
export HISTSIZE=100000
export HISTFILESIZE=200000
shopt -s histappend

# 重複削除（地味に重要）
HISTCONTROL=ignoredups:erasedups

# -------------------------------
# alias
# -------------------------------
if command -v eza >/dev/null 2>&1; then
  alias ls="eza"
  alias ll="eza -al"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi

alias lg='lazygit'

if grep -qi microsoft /proc/version 2>/dev/null; then
  if [ -x /mnt/c/Windows/System32/cmd.exe ]; then
    alias code='/mnt/c/Windows/System32/cmd.exe /C code'
    alias clip='/mnt/c/Windows/System32/clip.exe'
    alias paste='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe Get-Clipboard'
  fi
fi

