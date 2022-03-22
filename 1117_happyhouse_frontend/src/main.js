import Vue from "vue";
import DashboardPlugin from "./plugins/dashboard-plugin";
import App from "./App.vue";
// import { BootstrapVue, IconsPlugin } from "bootstrap-vue";
// router setup
import router from "./router/router.js";

// import "bootstrap/dist/css/bootstrap.css";
// import "bootstrap-vue/dist/bootstrap-vue.css";

import store from "./store/index.js";
import memberStore from "./store/modules/memberStore";
// plugin setup
Vue.use(DashboardPlugin);
// Vue.use(BootstrapVue);
// Vue.use(IconsPlugin);
Vue.config.productionTip = false;
/* eslint-disable no-new */

new Vue({
  el: "#app",
  render: (h) => h(App),
  async beforeCreate() {
    let token = sessionStorage.getItem("access-token");
    if (memberStore.state.userInfo == null && token) {
      await memberStore.dispatch("getUserInfo", token);
    }
  },
  store,
  router,
});
