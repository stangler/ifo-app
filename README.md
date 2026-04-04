# IFO計算ツール — Cloudflare Pages

## セットアップ

### 1. Devcontainerを起動
VS Code で「Reopen in Container」を実行するだけ。  
Node.js 20 と Wrangler が自動でインストールされます。

### 2. Cloudflareにログイン
```bash
make login
# ブラウザが開くので認証する
```

### 3. ローカルプレビュー
```bash
make preview
# http://localhost:8788 で確認できる
```

### 4. デプロイ
```bash
make deploy
# 初回のみプロジェクト作成の確認が出る → Y で進む
# デプロイ完了後に https://ifo-tool.pages.dev のURLが表示される
```

## Cloudflare Access の設定（認証）

デプロイ後、ダッシュボードで設定：

1. https://one.dash.cloudflare.com を開く
2. **Access → Applications → Add an application**
3. 「Self-hosted」を選択
4. Application domain に `ifo-tool.pages.dev` を入力
5. Policy を追加：
   - Action: `Allow`
   - Include: `Emails` → 自分のメールアドレス
6. Save

## ファイル構成

```
.
├── .devcontainer/
│   └── devcontainer.json   # Dev環境の定義
├── dist/
│   └── index.html          # デプロイ対象のHTML
├── wrangler.toml           # Cloudflare Pages設定
├── Makefile                # 便利コマンド
└── README.md
```
