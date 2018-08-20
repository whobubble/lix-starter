import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import { Socket } from "phoenix-socket";

Vue.config.productionTip = false;

new Vue({
  router,
  render: h => h(App)
}).$mount("#app");

let socket = new Socket("ws://localhost:4000/socket");
socket.connect();

Vue.prototype.$socket = socket;
