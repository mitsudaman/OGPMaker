
Nuxt.js + FirebaseでOGPの仕組みを完全に理解した話　〜俳句をSVGで描画するサービスをリリースした話〜


# TL;DR(要約)
Nuxt + Firebase を使って俳句を作成できるサービスを作りました
俳句メーカーはこちら
簡易デモサイトのソースコードはGit Hubにあげてます

# 自己紹介
個人的なプロジェクト「毎月サービスリリースで技術もノウハウもうっはうは祭り」をしています、ミツダマ(@mitudama)です。
1月の時間割メーカーに引き続き2月は俳句メーカーをリリースしました！
ノウハウうっはうはになったのでシェアします！

# 作ったサービス
twitter リンク
gif

#何で作ったか
・PeingとかボタンメーカーみたいなSNSでシェアしたときに画像が表示されるサービス作ってみたい
・OGPなにそれ？
・どうやらfirebaseを使えばサーバサイドなしで簡単にOGP系サービス作れるらしい
・枠内に文字数調整するのは面倒ではある
・俳句だったら文字数ほぼ決まってるし調整しやすいんじゃね？
・作っちゃえ
・作った　← イマココ

# 使った技術と参考サイト

##canvg 


  ## Inkscape使い方

  ・プロパティでviewbox設定
  ・最適化SVGで保存
  ・font 
  HiraginoSans-W5, Hiragino Sans

# OGPの流れ

①ユーザーAがtwitter上でサービスのURLをシェア

②twitter側はシェアされたURLにアクセスする

③firebase function は画像(OGPのメタタグ)を返す
 ※クローラーはjavascriptを認識できないためリダイレクト処理は行われない

④ユーザーBがサービスのURLにアクセスする

⑤firebase function はリダイレクト処理を行う(JavaScript)

# 最速でOGPサービスを作るチュートリアル

Inkscapeで作ったSVGを#svg_demo内に貼り付けます。

# vue init nuxt-community/starter-template front #front 部分は好きな名前で
        cd front
        npm install # Or yarn

        yarn add firebase
        yarn add canvg

        yarn dev

# SVGを動的に編集する
index.vue


# Firebase 設定

▼Firebase CLI リファレンス(公式)
https://firebase.google.com/docs/cli/?hl=ja

▼Docker×Nuxt×Firebaseを使ってSPAxPWAのWEBアプリ開発環境を構築する
https://www.bravesoft.co.jp/blog/archives/3942

 

 front# npm install -g firebase-tools #or yarn global add firebase-tools

 front# firebase login 


# Firebase デプロイ(Hosting)
front # yarn generate
front # firebase init

するといくつか質問されます。

? Which Firebase CLI features do you want to setup for this folder? Press Space to select features, then Enter to confirm your choices. (Press <space> toselect)
❯◯ Database: Deploy Firebase Realtime Database Rules
 ◯ Firestore: Deploy rules and create indexes for Firestore
 ◯ Functions: Configure and deploy Cloud Functions
 ◯ Hosting: Configure and deploy Firebase Hosting sites
 ◯ Storage: Deploy Cloud Storage security rules

今回はFunctionsとHostingをspaceで選択しエンター

=== Project Setup

First, let's associate this project directory with a Firebase project.
You can create multiple project aliases by running firebase use --add,
but for now we'll just set up a default project.

プロジェクトの選択ですが今はしなくてもいいので [don't setup a default project] で

? Select a default Firebase project for this directory: [don't setup a default project]

=== Functions Setup

A functions directory will be created in your project with a Node.js
package pre-configured. Functions can be deployed with firebase deploy.

言語はJavaScriptで
? What language would you like to use to write Cloud Functions? JavaScript

チュートリアルなのでEslintもなしで
? Do you want to use ESLint to catch probable bugs and enforce style? No
✔  Wrote functions/package.json
✔  Wrote functions/index.js
✔  Wrote functions/.gitignore

? Do you want to install dependencies with npm now? Yes

> grpc@1.18.0 install /OGPMaker/front/functions/node_modules/grpc
> node-pre-gyp install --fallback-to-build --library=static_library

node-pre-gyp WARN Using request for node-pre-gyp https download
[grpc] Success: "/OGPMaker/front/functions/node_modules/grpc/src/node/extension_binary/node-v64-linux-x64-musl/grpc_node.node" is installed via remote

> protobufjs@6.8.8 postinstall /OGPMaker/front/functions/node_modules/protobufjs
> node scripts/postinstall


> firebase-functions@2.2.0 postinstall /OGPMaker/front/functions/node_modules/firebase-functions
> node ./upgrade-warning


======== WARNING! ========

This upgrade of firebase-functions contains breaking changes if you are upgrading from a version below v1.0.0.

To see a complete list of these breaking changes, please go to:

https://firebase.google.com/docs/functions/beta-v1-diff

npm notice created a lockfile as package-lock.json. You should commit this file.
added 350 packages from 264 contributors and audited 930 packages in 21.811s
found 0 vulnerabilities

続いてHostingの設定です

=== Hosting Setup

Your public directory is the folder (relative to your project directory) that
will contain Hosting assets to be uploaded with firebase deploy. If you
have a build process for your assets, use your build's output directory.

どのディレクトリを公開しますか？ということなので先ほどnuxt generateで作成したdistディレクトリで
? What do you want to use as your public directory? dist

シングルページでいいのかと聞かれてるのでYesで
? Configure as a single-page app (rewrite all urls to /index.html)? Yes

既にindex.htmlあるけど上書きする？　しないです
? File dist/index.html already exists. Overwrite? No
i  Skipping write of dist/index.html

i  Writing configuration info to firebase.json...
i  Writing project information to .firebaserc...

✔  Firebase initialization complete!

これで完了！
次はブラウザ上のコンソールからプロジェクトを作成します。

front # firebase deploy

Error: No project active. Run with --project <projectId> or define an alias by
running firebase use --add

するとprojectIdを指定しなさいと怒られるので先ほど表示されたprojectIdを記載します
※コピペ忘れた方はコンソールのHostingを開けば記載されています

/front # firebase deploy --project <projectId>

=== Deploying to 'my-project-61b97'...

i  deploying functions, hosting
i  functions: ensuring necessary APIs are enabled...
✔  functions: all necessary APIs are enabled
i  functions: preparing functions directory for uploading...
i  hosting[my-project-61b97]: beginning deploy...
i  hosting[my-project-61b97]: found 9 files in dist
✔  hosting[my-project-61b97]: file upload complete
i  hosting[my-project-61b97]: finalizing version...
✔  hosting[my-project-61b97]: version finalized
i  hosting[my-project-61b97]: releasing new version...
✔  hosting[my-project-61b97]: release complete

✔  Deploy complete!

Please note that it can take up to 30 seconds for your updated functions to propagate.
Project Console: https://console.firebase.google.com/project/my-project-61b97/overview
Hosting URL: https://my-project-61b97.firebaseapp.com

最後に表示されたURLへアクセスして画面が表示されていればデプロイは完了です！


# Firebase strage　に画像をアップ

続いて画像を作成してstrageにアップしていきます。

▼Firebase strage スタートガイド
https://firebase.google.com/docs/storage/web/start?authuser=0


公開アクセスを設定する
開発時には、デフォルトの代わりに公開ルールを使用して、ファイルを公開して読み取りと書き込みができるように設定することができます

とあるので今回はお言葉に甘えて全公開で行きます



次にindex.vueの以下の部分を書き換えます。

var config = {
    apiKey: '<your-api-key>',
    authDomain: '<your-auth-domain>',
    databaseURL: '<your-database-url>',
    storageBucket: '<your-storage-bucket>'
  };

コンソール→Authentication→WEB設定で確認できます。



# Firebase Functions 


# 感想


# 終わりに