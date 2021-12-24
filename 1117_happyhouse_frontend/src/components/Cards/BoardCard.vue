<template>
  <card class="card-stats" :show-footer-line="true">
    <b-row>
      <b-col>
        <slot>
          <h5 class="card-title text-uppercase text-muted mb-0" v-if="title">
            {{ title }}
          </h5>
          <span class="h2 font-weight-bold mb-0" v-if="subTitle">
            <router-link
              v-if="articleno > 0"
              :to="{
                name: 'boardView',
                params: { articleno: `${articleno}` },
              }"
              >{{ subTitle }}</router-link
            >
            <div v-else>{{ subTitle }}</div>
          </span>
        </slot>
      </b-col>

      <b-col cols="auto" v-if="$slots.icon || icon">
        <slot name="icon">
          <div
            class="icon icon-shape text-white rounded-circle shadow"
            :class="[`bg-${type}`, iconClasses]"
          >
            <i :class="icon"></i>
          </div>
        </slot>
      </b-col>
    </b-row>

    <p class="mt-3 mb-0 text-sm">
      <slot name="footer"> </slot>
    </p>
  </card>
</template>
<script>
import Card from "./Card.vue";
//kakao
import { getKakaoToken, getKakaoUserInfo } from "@/api/login";
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";
// window.Kakao.init("6082f567e1510e9c68f57509bd7e571c");

export default {
  name: "stats-card",
  components: {
    Card,
  },
  props: {
    type: {
      type: String,
      default: "primary",
    },
    icon: String,
    title: String,
    subTitle: String,
    iconClasses: [String, Array],
    articleno: {
      type: Number,
      default: null,
    },
  },
  created() {
    if (this.$route.query.code) {
      this.setKakaoToken();
    }
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError"]),
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo", "setRegister"]),
    async setKakaoToken() {
      // console.log("카카오 인증 코드!", this.$route.query.code);
      // const query = this.$route.query.code;
      const { data } = await getKakaoToken(this.$route.query.code);
      // console.log(data);
      if (data.error) {
        alert("카카오톡 로그인 오류입니다.");
        this.$router.replace("/login");
        return;
      }
      window.Kakao.Auth.setAccessToken(data.access_token);
      // this.$cookies.set("access-token", data.access_token, "1d");
      // this.$cookies.set("refresh-token", data.refresh_token, "1d");

      const res = await getKakaoUserInfo();
      if (!res.kakao_account.email) {
        alert("이메일 동의가 필요합니다.");
        // window.Kakao.Auth.logout(function () {
        //   console.log(window.Kakao.Auth.getAccessToken());
        // });
        window.Kakao.API.request({
          url: "v1/user/unlink",
          success: function (response) {
            console.log("탈퇴", response);
            // callbackFunction();
          },
          fail: function (error) {
            console.log("탈퇴실패", error);
          },
        });
        this.loginWithKakao();
        return;
      }
      let user = {
        userid: res.kakao_account.email.split("@")[0],
        userpwd: "wlqdjqqlqjs1",
      };
      //login
      await this.userConfirm(user);
      let token = sessionStorage.getItem("access-token");
      if (this.isLogin) {
        // console.log("카카오 로그인");
        await this.getUserInfo(token);
        this.$router.push({ name: "dashboard" });
      } else {
        // console.log("카카오 회원가입");
        var name = res.kakao_account.profile.nickname;
        if (!name) name = "회원";
        let user = {
          userid: res.kakao_account.email.split("@")[0],
          username: name,
          userpwd: "wlqdjqqlqjs1",
          // 이거 보안상 문제되지만...일단이렇게...ㅎ
        };
        this.setRegister(user);
        this.$router.push({ name: "dashboard" });
      }
      //register
      // this.setRegister(this.user);

      // await this.setUserInfo();
      // this.$router.replace("/");
    },
    async setUserInfo() {
      const res = await getKakaoUserInfo();
      const userInfo = {
        name: res.kakao_account.profile.nickname,
        platform: "kakao",
      };
      this.$store.commit("setUser", userInfo);
    },
    // getInfo() {
    //   naverService().getUserInfo();
    // },
    // moneycard() {
    //   this.$router.push({ name: "moneycard" });
    // },
    loginWithKakao() {
      const params = {
        redirectUri: "http://localhost:8080/dashboard",
      };
      window.Kakao.Auth.authorize(params);
    },
  },
};
</script>
<style></style>
