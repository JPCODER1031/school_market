import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import ElementUI from "element-ui";
import axios from "./utils/axios";//后端数据交互
import globalVariable from "./utils/globalVariable";//全局变量
import AntUI from "ant-design-vue";//UI界面
import VEmojiPicker from 'v-emoji-picker';//表情引入
import VueSocketIO from "vue-socket.io";//websocket准备聊天用的
import Chat from 'jwchat';//聊天界面
// import 'jwchat/lib/JwChat.css';低版本需要引入这个
import "ant-design-vue/dist/antd.css";
import "element-ui/lib/theme-chalk/index.css";

Vue.config.productionTip = false;
Vue.prototype.$axios = axios;
Vue.prototype.$globalVariable=globalVariable;
Vue.use(Chat)
Vue.use(AntUI);
Vue.use(ElementUI);
Vue.use(VEmojiPicker);
Vue.use(
  new VueSocketIO({
    debug: true,
    connection: "http://127.0.0.1:3030"
  })
);
Vue.prototype.$EventBus=new Vue();
new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
