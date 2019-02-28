# GengoCandidate
- 2136文字の常用漢字から2字を組み合わせて元号候補を作成します
- 2136 * 2136 = 4562496通りの組み合わせが存在しますが、平成までの過去に元号として使われた組み合わせを除外すると、4562293通りが残ります

## Prerequisite
- sqlite3
Linux環境を想定していますが、WindowsでもWSL上で動作します。
WSLではなくWindows版sqlite3バイナリを使う場合は、scripts.sql中のパス表現を適宜書き換えてください。

## What's in this repos
<dl>
  <dt>johyohkanji.list</dt>
  <dd>2136文字の常用漢字一覧</dd>
  <dt>old_gengo.list</dt>
  <dd>平成以前の元号一覧</dd>
  <dt>scripts.sql</dt>
  <dd>元号候補生成SQL</dd>
  <dt>gengo_candidates.txt</dt>
  <dd>生成された元号候補一覧<br>※上記3ファイルはこのファイルを生成するためのリソースです。sqlite3実行環境を持たない方向けに、出力ファイルも公開しているだけで、ツール実行には不要です。</dd>
</dl>

## Usage
sqlite3 :memory: < scripts.sql
