■設定
docker-compose build
docker-compose up -d
docker-compose exec nuxt sh

//docker-compose run nuxt sh

/HaikuMaker vue init nuxt-community/starter-template

    ? Project name front
    ? Project description Nuxt.js project
    ? Author mitsudama

    vue-cli · Generated "front".

    To get started:
    
        cd front
        npm install # Or yarn
        npm run dev

/HaikuMaker # yarn install
    yarn install v1.10.1
    info No lockfile found.
    [1/4] Resolving packages...
    warning eslint > file-entry-cache > flat-cache > circular-json@0.3.3: CircularJSON is in maintenance only, flatted is its successor.


/HaikuMaker # yarn dev





--------------------------------------------
■bootstrap 導入yarn add bootstrap-vue
# With NPM:
npm i bootstrap-vue

# With Yarn:
yarn add bootstrap-vue
Add bootstrap-vue/nuxt to modules section of nuxt.config.js

{
  modules: [
    'bootstrap-vue/nuxt',

    // Or if you have custom bootstrap CSS...
    ['bootstrap-vue/nuxt', { css: false }],
  ]
}


--------------------------------------------
◾svgの変換(canvg)
/HaikuMaker # yarn add canvg

▼Twitterで草を生やせるTwithubを作った
https://qiita.com/SugarShootingStar/items/c9ea1113087cc2e6d238


https://github.com/SugarShootingStar/visualization-twitter-grass/blob/bafb35d58fcd3e983141bf7f777e530769e4843a/src/components/Heatmap.vue


左右に隙間が空いたりしたけど
      canvas.width = svg.width.baseVal.value;
      canvas.height = svg.height.baseVal.value;
とか
最高！！
あざああああす！

--------------------------------------------
◾fontawesome
https://yinm.info/20181008/
https://fontawesome.com/how-to-use/on-the-web/setup/using-package-managers

yarn add --dev @fortawesome/fontawesome-free
  css: [
    '@fortawesome/fontawesome-free/css/all.css',
  ],

--------------------------------------------
◾uuid

https://github.com/VitorLuizC/vue-uuid


--------------------------------------------
◾firebase に hosting

▼Firebase CLI リファレンス(公式)
https://firebase.google.com/docs/cli/?hl=ja

▼Docker×Nuxt×Firebaseを使ってSPAxPWAのWEBアプリ開発環境を構築する
https://www.bravesoft.co.jp/blog/archives/3942

コンテナ内で・・・
/TSMaker/front # yarn global add firebase-tools
/TSMaker/front # firebase login --no-localhost

? Allow Firebase to collect anonymous CLI usage and error reporting information? No
Visit this URL on any device to log in:
? Paste authorization code here: https~~~~

上のURLにアクセスすると「このコードをコピーし、アプリケーションに切り替えて貼り付けてください。
」とあるので貼り付ける
 Success! Logged in as [mail]


ここからデプロイ
/TSMaker/front # yarn generate
/TSMaker/front # firebase init

hostingとfunctionsを選択
/TSMaker/front # firebase deploy


Error: No project active. Run with --project <projectId> or define an alias by
running firebase use --add
/TSMaker/front # firebase use --add
? Which project do you want to add? nuxt-a86cb
? What alias do you want to use for this project? (e.g. staging) staging


/TSMaker/front # firebase deploy


--------------------------------------------
◾docker上からfunctionを更新する

"rewrites": [
      {
        "source": "/ogp/**", 
        "function": "ogp"
      },
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]"

exports.[]の部分をogpに変える

▼firebaseのみデプロイ
firebase deploy --only functions



--------------------------------------------
◾strage に アップする方法設定

▼strage スタートアップガイド(公式)
https://firebase.google.com/docs/storage/web/start?authuser=0


/HaikuMaker #yarn add firebase

以下をindex.vueに加える
    import firebase from 'firebase'

    // Webコンソールから取得したコンフィグをペースト
    const config = {
        apiKey: "AIzaSyDEdArWzhnmZiB1_Hy7Hq-Z3E_GL9cby3M",
        authDomain: "myportfolio-52fdd.firebaseapp.com",
        databaseURL: "https://myportfolio-52fdd.firebaseio.com",
        projectId: "myportfolio-52fdd",
        storageBucket: "myportfolio-52fdd.appspot.com",
        messagingSenderId: "884352941388"
      };
    firebase.initializeApp(config)


コンソールにログイン
Authentication　ページ
ウェブ設定にてスニペットが表示される



▼ECMAScript6のアロー関数とPromiseまとめ - JavaScript
thisの使い方について
https://qiita.com/takeharu/items/c23998d22903e6d3c1d9

❌ createRef.putString(image, 'base64').then(function(snapshot) 
⭕️ createRef.putString(image, 'base64').then((snapshot) =>{



--------------------------------------------
◾function index.js中でのfirestoreの接続


▼Cloud Firestore を使ってみる(Cloud Firestore を初期化する/NODE.JS)
https://firebase.google.com/docs/firestore/quickstart?hl=ja


▼Cloud Firestore でデータを取得する
https://firebase.google.com/docs/firestore/query-data/get-data?hl=ja



      // var date = new Date();
      // var six_days_ago = new Date(date.getFullYear(), date.getMonth(), date.getDate()-6, 0, 0);