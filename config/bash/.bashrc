# ~/.bashrc

# -------------------------------
# PATH（重複防止付き）
# -------------------------------
add_path() {
  case ":$PATH:" in
    *":$1:"*) ;;
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
# fdfind 対応
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

if command -v cargo >/dev/null 2>&1; then
  alias cr='cargo run'
  alias cb='cargo build'
  alias cbr='cargo build --release'
  alias ct='cargo test'
  alias cc='cargo check'
  alias ccl='cargo clippy'
  alias cf='cargo fmt'

  crr() { cargo run --release "$@"; }
  cw()  { cargo watch -x check -x test -x run; }
  cn()  { cargo new "$1" && cd "$1"; }
  cwrun() { cargo run -p "$1"; }
fi

alias lg='lazygit'

# WSL 専用エイリアス
if grep -qi microsoft /proc/version 2>/dev/null; then
  if [ -x /mnt/c/Windows/System32/cmd.exe ]; then
    alias code='/mnt/c/Windows/System32/cmd.exe /C code'
    alias clip='/mnt/c/Windows/System32/clip.exe'
    alias paste='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe Get-Clipboard'
  fi
fi
