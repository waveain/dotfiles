# dotfiles

個人の開発環境設定ファイル。WSL (Ubuntu) をメイン環境として想定。

## 構成

```
dotfiles/
├── bash/
│   ├── .bash_profile
│   ├── .bashrc
│   └── .config/bash/
│       ├── aliases.sh     # エイリアス定義
│       ├── exports.sh     # 環境変数
│       └── wsl.sh         # WSL専用設定
├── git/
│   ├── .gitconfig         # Git設定
│   └── .gitignore_global  # グローバルgitignore
├── packages/
│   └── apt.txt            # aptパッケージ一覧
├── ssh/
│   └── .ssh/
│       └── config             # SSH設定（GitHub用）
├── scripts/
│   ├── detect_os.sh           # OS検出ユーティリティ
│   └── setup_ssh.sh           # SSHキーセットアップ
└── install.sh                 # セットアップスクリプト
```

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
2. GNU Stow でシンボリックリンクを作成

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
