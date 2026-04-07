# エイリアス

# --- 基本コマンド ---
# eza がある場合は ls を置き換え
if command -v eza &>/dev/null; then
    alias ls='eza --icons'
    alias ll='eza -la --icons --git'
    alias la='eza -a --icons'
    alias l='eza --icons'
    alias lt='eza --icons --tree --level=2'
else
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

alias ..='cd ..'
alias ...='cd ../..'

alias grep='grep --color=auto'

# --- bat (Ubuntu では batcat としてインストールされる) ---
command -v batcat &>/dev/null && alias bat='batcat'
command -v bat &>/dev/null && alias cat='bat --paging=never'

# --- fd (Ubuntu では fdfind としてインストールされる) ---
command -v fdfind &>/dev/null && alias fd='fdfind'

# --- エディタ ---
alias vi='nvim'
alias vim='nvim'

# --- Git ---
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
