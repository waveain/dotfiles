# dotfiles

WSL (Ubuntu) 用の dotfiles です。

## 構成

```
dotfiles/
├── install.sh              # メインセットアップスクリプト
├── config/
│   ├── bash/.bashrc        # Bash 設定
│   ├── git/.gitconfig      # Git 設定
│   ├── nvim/init.lua       # Neovim 設定
│   ├── starship/starship.toml
│   ├── tmux/tmux.conf
│   └── wsl/wsl.conf
└── scripts/
    ├── install_packages.sh
    ├── install_rust.sh
    ├── install_rust_tools.sh
    ├── install_neovim.sh
    ├── install_starship.sh
    ├── install_lazygit.sh
    ├── install_docker.sh
    ├── setup_git.sh
    └── link_config.sh
```

## インストール

```bash
git clone https://github.com/waveain/dotfiles ~/dotfiles
cd ~/dotfiles
bash install.sh
```

> **Note:** `config/wsl/wsl.conf` の `YOUR_USERNAME` は WSL 再起動前に変更してください。
> その他のプレースホルダーについては下記「初回カスタマイズ」を参照してください。

## セットアップ内容

| ステップ | 内容 |
|---------|------|
| 1 | apt パッケージ（ripgrep, fzf, tmux, direnv など） |
| 2 | Rust / rustup |
| 3 | Rust ツール（atuin, zoxide, eza, bat） |
| 4 | Neovim（最新版） |
| 5 | Starship プロンプト |
| 6 | Lazygit |
| 7 | Docker |
| 8 | Git 初期設定 |
| 9 | 設定ファイルのシンボリックリンク |

## 初回カスタマイズ

- `config/git/.gitconfig` の `YOUR_NAME` / `YOUR_EMAIL` を変更
- `config/wsl/wsl.conf` の `YOUR_USERNAME` を変更
