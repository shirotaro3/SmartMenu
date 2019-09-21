# SmartMenu

## 説明  
  
SmartMenuは主に個人経営の飲食店など向けのメニュー作成アプリです。  
紙のメニューの代わりにQRコードを設置することで、利用者のスマートフォンから簡単にメニューを閲覧できるようになります。  
  
***デモ***  
  
[デモサイト]  
  
***サンプルアカウント***  
  
Eメール：　sample@sample.com  
パスワード： sample3ple
  
***使い方***  
  
*デモサイトにログイン後に、「ご利用方法ページ」をご覧ください。*  
<br>
  
## 機能  
  
### メニュー作成機能  
サイト上でメニューを作成・閲覧できます。メイン機能です。  
  
### QRコード作成機能  
作成したメニューを開くためのQRコードを生成できます。  
PDF形式で出力され、サイズが２種類用意されています。  
  
### テーマカラー変更機能  
メニューのテーマカラーをあらかじめ用意された10種類以上のカラーから選択し、変更することができます。  
  
### エモーション機能  
お店の利用者は３つのアイコンから選択して、ワンクリックでお店にフィードバックを送ることができます。  
  
### リクエスト機能  
お店の利用者はメニューに設置されたフォームから、お店にメッセージを送信することができます。  
<br>

## 使用した技術  
  
### サーバーサイド  
- 言語：Ruby  
- フレームワーク：Ruby On Rails  
  
### フロントエンド  
- CSSフレームワーク：　Bulma  
- JavaScriptライブラリ： JQuery  
- テンプレートエンジン：　haml  
  
### テスト  
- RSpec  
  
### 本番サーバ環境  
- AWS  
- データベース：MySQL  
- WEBサーバ：Apache  
<br>

## アピールポイント  
  
### 1.　RSpecによるテストの実施  
- RSpecのテストコードを作成し、テストをしました。  
  
### 2.　Dockerを利用したデプロイ  
- 本番環境の構築にDockerを利用しました。  
  
### 3.　自作ログイン機能  
- お店側はdeviseによるログイン機能を使用し、管理者側では自作ログイン機能を実装しました。  
  
### 4.　各種機能  
- エモーション機能では、ユーザー登録なしでも連続的な投稿を制御できるよう、セッションを利用しました。  
  
- QR作成機能ではQRコード生成＋PDF出力を合わせ、印刷しやすいように工夫しました。  
  
### 5.　レスポンシブ対応  
- 管理者ページを含む、サイトの全ページをレスポンシブ対応しました。  