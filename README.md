# dev-env-setup

AlmaLinux 10（RHEL 10 互換 / el10）向け開発環境を、[mitamae](https://github.com/k0kubun/mitamae) で冪等にセットアップするリポジトリです。

## 対象環境

- AlmaLinux 10（確認済み: 10.2）
- WSL2 上での利用を想定
- アーキテクチャ: x86_64（x86-64-v3 以上推奨）

## 前提

- `curl` が使えること（`mitamae` の取得に使用）
- `sudo` が使えること
- セットアップ対象の Linux ユーザーが存在すること

## 使い方

```sh
./bin/setup
```

実行すると、次を対話的に尋ねます。

1. Linux ユーザー名（デフォルト: 現在のユーザー）
2. Git 用メールアドレス

入力内容は `.node.local.json` に保存され、再実行時は前回値がデフォルトになります（このファイルは gitignore 済み）。`git.name` には、入力した Linux ユーザー名と同じ値が使われます。

その後 `bin/setup` は次を行います。

1. OS が AlmaLinux 10 (el10) であることを確認する
2. `mitamae` バイナリがなければ GitHub から取得する
3. `sudo` 付きで設定を読み込み、`main.rb` を実行する

あらかじめ `.node.local.json` を用意して非対話で流す場合:

```sh
./bin/setup --non-interactive
```

## 設定ファイル

| ファイル | 用途 |
|----------|------|
| `.node.local.json` | 対話入力の結果（実行時に生成、個人情報のため gitignore） |
| `node.json.example` | 設定のサンプル |

## セットアップ内容

`main.rb` から次の cookbook を順に適用します。

| cookbook | 内容 |
|----------|------|
| `base` | el10 確認、CRB 有効化、EPEL 10 導入、Development Tools、Homebrew 用依存（パッケージ導入は `dnf` 直接。mitamae の `package` は `yum` 依存のため未使用） |
| `brew` | Homebrew のインストール、fish への `brew shellenv` 追加 |
| `fish` | EPEL から fish 4.x を導入、デフォルトシェル化、fisher / bobthefish、alias |
| `git` | `user.name` / `user.email` の global 設定 |
| `ghq` | Homebrew 経由で ghq をインストール |

### AlmaLinux 10 固有のポイント

- **CRB** は AlmaLinux 10 ではデフォルト有効。無効な環境向けに cookbook 側でも有効化する
- **fish** はベースリポジトリには無く、**EPEL 10** から入れる（fish 4.x）
- **glibc 2.39** のため、Homebrew on Linux の要件を満たす

### fish に追加される alias

- `gs` → `git switch`
- `dce` → `docker compose exec`
- `dcu` → `docker compose up`

## ディレクトリ構成

```
.
├── bin/setup
├── main.rb
├── node.json.example
├── cookbooks/
│   ├── helpers/
│   ├── base/
│   ├── brew/
│   ├── fish/
│   ├── git/
│   └── ghq/
└── README.md
```
