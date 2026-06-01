# Gherkin → ステップ定義 生成プロンプト

## プロンプト

```
以下の情報を元に、playwright-bdd のステップ定義（TypeScript）を生成してください。

## .feature ファイル
\`\`\`gherkin
[ここに .feature ファイルの内容を貼る]
\`\`\`

## playwright codegen の記録
\`\`\`typescript
[ここに scripts/codegen.bat で記録したコードを貼る]
\`\`\`

## 既存の Page Object（再利用すること）
\`\`\`typescript
[ここに e2e/pages/ の関連ファイルを貼る（なければ省略）]
\`\`\`

## 生成ルール
- `createBdd()` で Given/When/Then を取得する
- ステップパラメータは {string} / {int} を使う
- Page Object が使えるものは積極的に使う
- 要素取得は data-testid を優先する（getByTestId）
- expect の timeout は書かない（デフォルトを使う）
- 出力ファイル名: e2e/steps/[機能名].steps.ts
```

---

## ワークフロー

```
① e2e/features/ に .feature ファイルを書く（日本語シナリオ）
      ↓
② scripts/codegen.bat を実行して操作を記録
      ↓
③ .feature + codegen 記録 を Claude に渡す
      ↓
④ Claude が e2e/steps/*.steps.ts を生成
      ↓
⑤ npm test で実行・確認
```
