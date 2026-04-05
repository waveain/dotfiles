#!/usr/bin/env bash
# OS/環境を検出するユーティリティ
# 他スクリプトから source して使う

detect_os() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/debian_version ]; then
        echo "ubuntu"
    else
        echo "unknown"
    fi
}

is_wsl()    { [ "$(detect_os)" = "wsl" ]; }
is_arch()   { [ "$(detect_os)" = "arch" ]; }
is_ubuntu() { [ "$(detect_os)" = "ubuntu" ] || [ "$(detect_os)" = "wsl" ]; }
