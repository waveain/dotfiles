# dotfiles

個人の開発環境設定ファイル。WSL (Ubuntu) をメイン環境として想定。

## 構成

```
dotfiles/
├── bash/
│   ├── .bash_profile
│   ├── .bashrc
│   └── .config/bash/
│       ├── aliases.sh     # エイリアス定義（eza/bat/fd対応）
│       ├── exports.sh     # 環境変数（fzf/zoxide設定含む）
│       └── wsl.sh         # WSL専用設定
├── git/
│   ├── .gitconfig         # Git設定（delta pager含む）
│   └── .gitignore_global  # グローバルgitignore
├── nvim/
│   └── .config/nvim/
│       ├── init.lua       # lazy.nvim ブートストラップ
│       └── lua/
│           ├── config/
│           │   ├── options.lua    # vim設定
│           │   └── keymaps.lua    # キーマップ
│           └── plugins/
│               ├── colorscheme.lua  # tokyonight
│               ├── telescope.lua    # ファジーファインダー
│               ├── treesitter.lua   # シンタックスハイライト
│               ├── lsp.lua          # LSP + 補完 (mason/lspconfig/cmp)
│               └── ui.lua           # lualine + neo-tree
├── tmux/
│   └── .tmux.conf             # tmux設定（C-a プレフィックス、hjkl移動）
├── starship/
│   └── .config/
│       └── starship.toml      # Catppuccin Mocha 2行プロンプト
├── editorconfig/
│   └── .editorconfig          # エディタ間のスタイル統一
├── packages/
│   └── apt.txt                # aptパッケージ一覧
├── ssh/
│   └── .ssh/
│       └── config             # SSH設定（GitHub用）
├── mise/
│   └── .config/mise/
│       └── config.toml        # mise管理ツール設定（node/rust/python/uv）
├── scripts/
│   ├── detect_os.sh           # OS検出ユーティリティ
│   ├── install_extras.sh      # gh/eza/zoxide/mise/uv/starship インストール
│   └── setup_ssh.sh           # SSHキーセットアップ
└── install.sh                 # セットアップスクリプト
```

## インストールされるツール

| ツール | 用途 |
|--------|------|
| `fzf` | あいまい検索（`Ctrl+R` 履歴、`Ctrl+T` ファイル、`Alt+C` ディレクトリ） |
| `ripgrep` | 高速grep、neovimとの連携 |
| `bat` | catの代替（シンタックスハイライト） |
| `fd-find` | findの代替（高速・使いやすい） |
| `tmux` | ターミナルマルチプレクサ（プレフィックス `C-a`、`hjkl` でペイン移動） |
| `jq` | JSON整形・パース |
| `git-delta` | git diffの見やすい表示 |
| `gh` | GitHub CLI |
| `eza` | lsの代替（カラー・gitステータス表示） |
| `zoxide` | cdの代替（頻繁に訪れるディレクトリへ即移動） |
| `starship` | クロスシェルプロンプト（Catppuccin Mocha テーマ） |
| `mise` | 開発ツールのバージョン管理（node/rust/python/uv等） |
| `uv` | 高速Pythonパッケージマネージャ |

## セットアップ

### 必要なもの

- `git`
- `stow`

### 手順

```bash
git clone https://github.com/waveain/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` は以下を行います：

1. `apt.txt` に記載のパッケージをインストール
2. `install_extras.sh` で gh / eza / zoxide / mise / uv / starship をインストール
3. GNU Stow でシンボリックリンクを作成（bash, git, ssh, nvim, mise, tmux, starship, editorconfig）
4. `mise install` で node / rust / python / uv をインストール

完了後、設定を反映するには：

```bash
source ~/.bashrc
```

## SSH設定（GitHub）

`~/.ssh/config` はdotfilesで管理しています。秘密鍵は含まれません。

`setup_ssh.sh` を実行すると、鍵の有無に応じて以下の処理を行います：

- **鍵あり** → GitHubへの接続テストを実施
  - 成功 → そのまま終了
  - 失敗 → 公開鍵を表示してGitHubへの登録を促す
- **鍵なし** → 生成するか確認し、Yなら鍵を作成して公開鍵を表示

```bash
# デフォルト (id_ed25519)
bash ~/dotfiles/scripts/setup_ssh.sh

# 鍵名を指定する場合
bash ~/dotfiles/scripts/setup_ssh.sh id_ed25519_wsl
```

## 個人情報の設定

このリポジトリには個人情報を含めていません。以下のファイルを別途作成してください。

### Git ユーザー情報

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

または `~/.gitconfig.local` を作成：

```ini
[user]
    name = Your Name
    email = your@email.com
```

### APIキー・秘密情報

`~/.config/bash/exports.local.sh` を作成し、環境変数を定義：

```bash
export SOME_API_KEY="your-api-key"
```

このファイルは `.gitignore` により追跡されません。
