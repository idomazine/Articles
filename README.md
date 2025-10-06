# Articles – ニュースアプリサンプル

このリポジトリは、iOSのニュースアプリを模したプロジェクトです。架空ニュースの一覧・閲覧・ブックマーク・コメント投稿に対応し、TCA を用いた状態管理と Layered Architecture を実践しています。

<img width="320" src="https://github.com/user-attachments/assets/49f9cff2-a4d1-4303-91d1-9f9b426f348b" />

## 環境
- **OS**: macOS Tahoe 26.0
- Xcode: 26.0
- 言語: Swift
- UI: SwiftUI
- 状態管理: The Composable Architecture (TCA)
- アーキテクチャ: Layered Architecture（Presentation → Domain → Infra → Library）
- テストフレームワーク: Swift Testing


## 機能概要
### タブ構成
- **ニュース一覧** / **お気に入り** / **プロフィール** の 3 タブ
- **URLスキーム**による画面遷移に対応（詳細は後述）

### ニュース一覧タブ
- 架空ニュースの**一覧表示**
- **非同期通信**でデータ取得
- **無限スクロール**対応（リスト末尾で次ページを読み込み）
- 記事を選択すると**記事詳細**へ遷移

### ニュース記事詳細
- 記事の**全文表示**
- **コメント一覧**の表示
- **お気に入りボタン**で追加/削除
- **コメント投稿ボタン**で**モーダル表示**（投稿画面）

### コメント投稿
- コメントの**入力**および**投稿**
- **投稿通信中はモーダル操作をロック**（二重送信/離脱を防止）

### お気に入りタブ
- 追加済みの記事を**一覧表示**
- **スワイプで削除**
- 記事を選択すると**記事詳細**へ遷移

### プロフィールタブ（Profile）
- **メールアドレスの編集**（**変更は永続化**）
- **アプリバージョンの表示**


## アーキテクチャ

本アプリは Layered Architecture を採用しています。

- **Presentation**: UIの表示とイベントのハンドリング。
- **Domain**: ビジネスロジック及びUseCase機能の提供。
- **Infra**: ネットワークやストレージによる永続化へのアクセスを提供。
- **Library**: ユーティリティ群。

## URLスキーム

URLスキームによる画面遷移をサポートしています。

- `articles://articles`: ニュース一覧
- `articles://articles/:id`: 指定 ID の記事詳細（例: `articles://articles/42`）
- `articles://favorites`: お気に入り一覧
- `articles://profile`: プロフィール

## キャプチャ

### お気に入り
各ニュースをお気に入りに追加すると、お気に入り一覧で表示されます。
お気に入りを解除すると一覧からも削除されます。

<video src="https://github.com/user-attachments/assets/96770351-cd38-4bb3-8d1e-7e0b44a80fe8"></video>

### コメント
各ニュースはコメント追加が可能です。
API通信を模していますが、投稿したコメントはSwiftDataで保存しています。

<video src="https://github.com/user-attachments/assets/9fdb2e5a-98f5-4a10-8c94-a9376ea71021"></video>

### 無限スクロール
ニュース一覧を一番下までスクロールすると、次のページの読み込みを開始します。

<video src="https://github.com/user-attachments/assets/b80eba57-8d5f-4d69-8434-ff46d00ff75c"></video>
