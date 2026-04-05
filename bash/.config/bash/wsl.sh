# WSL専用設定

# Windowsホームディレクトリ
export WINHOME="/mnt/c/Users/$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')"

# クリップボード連携
alias pbcopy='clip.exe'
alias pbpaste='powershell.exe -command Get-Clipboard'

# Windowsエクスプローラーで現在ディレクトリを開く
alias open='explorer.exe'
