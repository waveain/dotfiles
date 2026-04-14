# WSL専用設定

# Windowsホームディレクトリ
if command -v wslvar &>/dev/null; then
    export WINHOME="/mnt/c/Users/$(wslvar USERNAME 2>/dev/null)"
else
    export WINHOME="/mnt/c/Users/$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')"
fi

# クリップボード連携
alias pbcopy='clip.exe'
alias pbpaste='powershell.exe -command Get-Clipboard'

# Windowsエクスプローラーで現在ディレクトリを開く
alias open='explorer.exe'
