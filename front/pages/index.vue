<template>
  <section class="container">
    <div>
      <div>
        <svg ref="svgArea" viewBox="0 0 200 100">
          <rect x="0" y="0" width="200" height="100" fill="#fff" stroke="#12b886" stroke-width="15"></rect>
          <text 
          x="50%" 
          y="50%" 
          font-size="8px"
          text-anchor="middle">{{text1}}</text>
        </svg>
      </div>
      <div style="text-align:right">
        <input v-model="text1" type="text" style="width:100%; margin-bottom:10px">
        <button @click="create">つくる</button>
      </div>
    </div>
  </section>
</template>

<script>
import firebase from 'firebase'
import canvg from 'canvg';
// Set the configuration for your app
// TODO: Replace with your project's config object
var config = {
  apiKey: '<your-api-key>',
  authDomain: '<your-auth-domain>',
  databaseURL: '<your-database-url>',
  storageBucket: '<your-storage-bucket>'
};
  firebase.initializeApp(config);

if (!firebase.apps.length) {
    firebase.initializeApp(config);
}

export default {
  components: {
  },
  data() {
    return {
      text1: 'ヤクザの先輩にエアギター売ってもらった',
    };
  },
  methods: {
    create() {
      var storageRef = firebase.storage().ref();
      var createRef = storageRef.child('test.jpg');

      // 擬似canvas要素を作成
      var canvas = document.createElement('canvas')
      var svg = this.$refs.svgArea
      canvas.width = svg.width.baseVal.value;
      canvas.height = svg.height.baseVal.value;
      
      // SVG → Canvas 変換
      const data = new XMLSerializer().serializeToString(this.$refs.svgArea);
      canvg(canvas, data)

      // 作成
      let image = canvas.toDataURL('image/jpeg').split(',')[1]
      createRef.putString(image, 'base64').then((snapshot) =>{
        console.log('Uploaded a blob or file!');
      });
    }
  }
}
</script>

<style>
.container {
  width: 800px;
  height: 800px;
  margin-top: 50px;
  margin-right: auto;
  margin-left: auto;
}
</style>

