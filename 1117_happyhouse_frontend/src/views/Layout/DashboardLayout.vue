<template>
  <div class="wrapper">
    <side-bar>
      <template slot="links">
        <sidebar-item
          :link="{
            name: 'Home',
            path: '/dashboard',
            icon: 'ni ni-tv-2 text-primary',
          }"
        >
        </sidebar-item>

        <sidebar-item
          :link="{
            name: 'Maps',
            path: '/maps',
            icon: 'ni ni-pin-3 text-orange',
          }"
        >
        </sidebar-item>

        <!-- <sidebar-item
          :link="{
            name: 'Maps',
            path: '/mapscopy',
            icon: 'ni ni-pin-3 text-purple',
          }"
        >
        </sidebar-item> -->
        <sidebar-item
          :link="{
            name: 'Board',
            path: '/board',
            icon: 'ni ni-bullet-list-67 text-green',
          }"
        >
        </sidebar-item>
        <sidebar-item
          :link="{
            name: 'Notice',
            path: '/notice',
            icon: 'ni ni-air-baloon text-red',
          }"
        >
        </sidebar-item>

        <sidebar-item
          v-if="userInfo"
          :link="{
            name: 'User Profile',
            path: '/profile',
            icon: 'ni ni-single-02 text-yellow',
          }"
        >
        </sidebar-item>

        <!-- <sidebar-item
          :link="{
            name: 'Tables',
            path: '/tables',
            icon: 'ni ni-bullet-list-67 text-red',
          }"
        >
        </sidebar-item> -->

        <sidebar-item
          v-if="!userInfo"
          :link="{
            name: 'Login',
            path: '/login',
            icon: 'ni ni-key-25 text-info',
          }"
        >
        </sidebar-item>
        <sidebar-item
          v-if="!userInfo"
          :link="{
            name: 'Register',
            path: '/register',
            icon: 'ni ni-circle-08 text-pink',
          }"
        >
        </sidebar-item>
      </template>
    </side-bar>
    <div class="main-content">
      <dashboard-navbar :type="$route.meta.navbarType"></dashboard-navbar>

      <div @click="$sidebar.displaySidebar(false)">
        <fade-transition :duration="200" origin="center top" mode="out-in">
          <!-- your content here -->
          <router-view></router-view>
        </fade-transition>
      </div>
      <content-footer v-if="!$route.meta.hideFooter"></content-footer>
    </div>
  </div>
</template>
<script>
import { mapState } from "vuex";

const memberStore = "memberStore";
/* eslint-disable no-new */
import PerfectScrollbar from "perfect-scrollbar";
import "perfect-scrollbar/css/perfect-scrollbar.css";

function hasElement(className) {
  return document.getElementsByClassName(className).length > 0;
}

function initScrollbar(className) {
  if (hasElement(className)) {
    new PerfectScrollbar(`.${className}`);
  } else {
    // try to init it later in case this component is loaded async
    setTimeout(() => {
      initScrollbar(className);
    }, 100);
  }
}

import DashboardNavbar from "./DashboardNavbar.vue";
import ContentFooter from "./ContentFooter.vue";
import DashboardContent from "./Content.vue";
import { FadeTransition } from "vue2-transitions";

export default {
  components: {
    DashboardNavbar,
    ContentFooter,
    DashboardContent,
    FadeTransition,
  },
  methods: {
    initScrollbar() {
      let isWindows = navigator.platform.startsWith("Win");
      if (isWindows) {
        initScrollbar("sidenav");
      }
    },
  },
  mounted() {
    this.initScrollbar();
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
};
</script>
<style lang="scss"></style>
