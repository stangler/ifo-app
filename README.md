# IFO計算ツール

個人用デイトレード向けの IFO（In/First/Out）注文計算ツール。  
エントリー価格または SL 価格を入力するだけで、TP・SL 価格を自動算出します。

## 機能

- **ロング / ショート** の切り替え
- **エントリー価格 → TP・SL 自動計算**
- **SL 価格 → エントリー・TP 自動計算**（逆算モード）
- SL 固定 **−0.35%**、TP ≈ **+0.5845%**（RRR 1.67）

## 本番環境

| 項目 | 内容 |
|------|------|
| URL | `https://ifo-tool.pages.dev` |
| ホスティング | Cloudflare Pages |
| 認証 | Cloudflare Access（Self-hosted / メール認証） |
| アクセス制限 | 登録メールアドレス 1 件のみ |

## 開発環境のセットアップ

### 前提

- Docker Desktop（Dev Container 用）
- VS Code + [Dev Containers 拡張](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- Cloudflare API トークン（Pages 編集権限）

### 手順

1. リポジトリをクローン

   ```bash
   git clone https://github.com/stangler/ifo-app.git
   cd ifo-app
   ```

2. `.devcontainer/devcontainer.json` に API トークンを設定

   ```jsonc
   // .devcontainer/devcontainer.json（.gitignore で除外済み）
   {
     "remoteEnv": {
       "CLOUDFLARE_API_TOKEN": "<your-api-token>"
     }
   }
   ```

3. VS Code で **「Reopen in Container」** を実行

4. 依存パッケージをインストール

   ```bash
   pnpm install
   ```

### ファイル構成

```
ifo-app/
├── .devcontainer/
│   └── devcontainer.json   # APIトークン設定（.gitignore で除外）
├── dist/
│   └── index.html          # ツール本体（シングルページ HTML）
├── .npmrc                  # shamefully-hoist=true
├── .gitignore
├── package.json
├── pnpm-lock.yaml
├── wrangler.toml           # name = "ifo-tool"
├── Makefile
└── README.md
```

## 開発・デプロイ

```bash
# Cloudflare Pages へデプロイ
make deploy

# wrangler を直接実行する場合
pnpm exec wrangler pages deploy dist --project-name ifo-tool
```

> **Note**  
> `wrangler login` は使用しません。認証は `CLOUDFLARE_API_TOKEN` 環境変数で行います。

## 技術スタック

| 項目 | 採用技術 |
|------|----------|
| フロントエンド | HTML / CSS / Vanilla JS（依存ゼロ） |
| ホスティング | Cloudflare Pages |
| 認証 | Cloudflare Access |
| デプロイツール | Wrangler 4.x |
| パッケージマネージャ | pnpm 10.x |
| 開発環境 | Dev Container（Node.js 20） |

## コミットルール

[Conventional Commits](https://www.conventionalcommits.org/) 形式を使用します。

```
<type>(<scope>): <subject>
```

| type | 用途 |
|------|------|
| `feat` | 新機能 |
| `fix` | バグ修正 |
| `docs` | ドキュメントのみの変更 |
| `style` | フォーマット等（動作変更なし） |
| `refactor` | リファクタリング |
| `test` | テスト追加・修正 |
| `chore` | ビルド・設定等の変更 |

- subject は**日本語**、72 文字以内
- 複雑な変更には body で「なぜ」を説明

## セキュリティに関する注意

- API トークンは `.devcontainer/devcontainer.json` にのみ記載し、`.gitignore` で Git 管理対象外にしています
- 本番ツールへのアクセスは Cloudflare Access で制限されています
- このリポジトリ自体は Public ですが、秘密情報はコミットされていません
