<template>
  <div>
    <!-- Cards -->
    <base-header
      class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success"
      style="height: 450px"
    >
      <!-- Card stats -->
      <!-- <b-row class="pl-4 pb-4">
        <div class="top-title-selected pr-3" @click="boardcard()">
          실시간 인기글
        </div>
        <div class="top-title-selected pl-2 pr-2">|</div>
        <div class="top-title-unselected pr-3" @click="boardcard()">
          관심 지역
        </div>
        <div class="top-title-selected pl-2 pr-2">|</div>
        <div class="top-title-unselected pr-2" @click="boardcard()">
          거래 금액
        </div>
      </b-row> -->
      <b-row>
        <b-col cols="4">
          <div>
            <!-- <b-tabs content-class="mt-3 " fill>
              <b-tab
                title="인기글"
                title-item-class="mytab"
                active
                @click="boardcard()"
              ></b-tab>
              <b-tab
                title="관심 지역"
                title-item-class="mytab"
                @click="wishcard()"
              ></b-tab>
              <b-tab
                title="거래 금액"
                title-item-class="mytab"
                @click="moneycard()"
              ></b-tab>
            </b-tabs> -->
            <div class="mb-4">
              <span :class="firstClass" @click="boardcard()">인기 게시물</span>
              <span :class="secondClass" @click="wishcard()"
                >인기 관심지역</span
              >
              <!-- <hr style="border: solid; height: 3px background: #ccc;" /> -->
            </div>
          </div>
        </b-col>
      </b-row>
      <!-- <board-card></board-card> -->
      <!-- <card></card> -->
      <router-view></router-view>
    </base-header>
    <!--Charts-->
    <b-container fluid class="mt--7">
      <!-- <b-row>
        <b-col xl="8" class="mb-5 mb-xl-0">
          <card type="default" header-classes="bg-transparent">
            <b-row align-v="center" slot="header">
              <b-col>
                <h6 class="text-light text-uppercase ls-1 mb-1">Overview</h6>
                <h5 class="h3 text-white mb-0">Sales value</h5>
              </b-col>
              <b-col>
                <b-nav class="nav-pills justify-content-end">
                  <b-nav-item
                       class="mr-2 mr-md-0"
                       :active="bigLineChart.activeIndex === 0"
                       link-classes="py-2 px-3"
                       @click.prevent="initBigChart(0)">
                      <span class="d-none d-md-block">Month</span>
                      <span class="d-md-none">M</span>
                  </b-nav-item>
                  <b-nav-item
                    link-classes="py-2 px-3"
                    :active="bigLineChart.activeIndex === 1"
                    @click.prevent="initBigChart(1)"
                  >
                    <span class="d-none d-md-block">Week</span>
                    <span class="d-md-none">W</span>
                  </b-nav-item>
                </b-nav>
              </b-col>
            </b-row>
            <line-chart
              :height="350"
              ref="bigChart"
              :chart-data="bigLineChart.chartData"
              :extra-options="bigLineChart.extraOptions"
            >
            </line-chart>
          </card>
        </b-col>

        <b-col xl="4" class="mb-5 mb-xl-0">
          <card header-classes="bg-transparent">
            <b-row align-v="center" slot="header">
              <b-col>
                <h6 class="text-uppercase text-muted ls-1 mb-1">Performance</h6>
                <h5 class="h3 mb-0">Total orders</h5>
              </b-col>
            </b-row>

            <bar-chart
              :height="350"
              ref="barChart"
              :chart-data="redBarChart.chartData"
            >
            </bar-chart>
          </card>
        </b-col>
      </b-row> -->
      <!-- End charts-->

      <!--Tables-->
      <b-row class="mt-5">
        <b-col xl="6" class="mb-5 mb-xl-0">
          <free-board-table></free-board-table>
        </b-col>
        <b-col xl="6" class="mb-5 mb-xl-0">
          <notice-board-table></notice-board-table>
        </b-col>
      </b-row>
      <!--End tables-->
    </b-container>
  </div>
</template>
<script>
// Charts
import * as chartConfigs from "@/components/Charts/config";
import LineChart from "@/components/Charts/LineChart";
import BarChart from "@/components/Charts/BarChart";

// Components
import BaseProgress from "@/components/BaseProgress";

// Tables
// import SocialTrafficTable from './Dashboard/SocialTrafficTable';
// import PageVisitsTable from './Dashboard/PageVisitsTable';
import FreeBoardTable from "./Dashboard/FreeBoardTable";
import NoticeBoardTable from "./Dashboard/NoticeBoardTable";

import Card from "@/views/HomeCard/Card.vue";

//kakao
import { getKakaoToken, getKakaoUserInfo } from "@/api/login";
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";
window.Kakao.init("6082f567e1510e9c68f57509bd7e571c");

export default {
  components: {
    LineChart,
    BarChart,
    BaseProgress,
    Card,
    FreeBoardTable,
    NoticeBoardTable,
  },
  data() {
    return {
      topHits: [],
      firstClass: "spread-underline-selected",
      secondClass: "spread-underline",
      bigLineChart: {
        allData: [
          [0, 20, 10, 30, 15, 40, 20, 60, 60],
          [0, 20, 5, 25, 10, 30, 15, 40, 40],
        ],
        activeIndex: 0,
        chartData: {
          datasets: [
            {
              label: "Performance",
              data: [0, 20, 10, 30, 15, 40, 20, 60, 60],
            },
          ],
          labels: ["May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        },
        extraOptions: chartConfigs.blueChartOptions,
      },
      redBarChart: {
        chartData: {
          labels: ["Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
          datasets: [
            {
              label: "Sales",
              data: [25, 20, 30, 22, 17, 29],
            },
          ],
        },
        extraOptions: chartConfigs.blueChartOptions,
      },
    };
  },
  created() {
    if (this.$route.query.code) {
      this.setKakaoToken();
    }
    // this.boardcard();
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo", "setRegister"]),
    initBigChart(index) {
      let chartData = {
        datasets: [
          {
            label: "Performance",
            data: this.bigLineChart.allData[index],
          },
        ],
        labels: ["May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
      };
      this.bigLineChart.chartData = chartData;
      this.bigLineChart.activeIndex = index;
    },
    boardcard() {
      // this.$router.replace({ name: "card", params: { type: "board" } });
      this.firstClass = "spread-underline-selected";
      this.secondClass = "spread-underline";
      this.$router.push({ name: "boardcard" });
    },
    wishcard() {
      this.secondClass = "spread-underline-selected";
      this.firstClass = "spread-underline";
      this.$router.push({ name: "wishcard" });
    },
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
  mounted() {
    this.initBigChart(0);
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError"]),
  },
};
</script>
<style>
.el-table .cell {
  padding-left: 0px;
  padding-right: 0px;
}
.bg-success {
  background: #2186c4 !important;
}
.top-title-selected {
  color: whitesmoke;
  font-size: 20px;
  font-weight: bold;
}
.top-title-unselected {
  color: dark-gray;
  font-size: 20px;
  font-weight: bold;
}

/* .mytab .nav-link:not(.active) {
  background-color: red !important;
  color: darkslategray;
  font-size: 20px;
  font-weight: bold;
}
.mytab .nav-link {
  color: darkslategray;
  font-size: 20px;
  font-weight: bold;
  background-color: blue !important;
} */

/* .tab-content > .tab-pane {
  border: 1px solid;
  border-left: 0px none;
} */

/*가운데서 좌우로 펼쳐지는 라인 에니메이션*/
span {
  animation-fill-mode: forwards;
}
.spread-underline {
  color: #333;
  text-decoration: none;
  display: inline-block;
  padding: 10px 0;
  margin-right: 20px;
  position: relative;
  font-weight: bold;
  font-size: 18px;
}
.spread-underline:after {
  color: whitesmoke;
  background: none repeat scroll 0 0 transparent;
  bottom: 0;
  content: "";
  display: block;
  height: 2px;
  left: 50%;
  position: absolute;
  background: whitesmoke;
  transition: width 0.3s ease 0s, left 0.3s ease 0s;
  width: 0;
}
.spread-underline:hover:after {
  color: whitesmoke;
  width: 100%;
  left: 0;
}
.spread-underline:hover {
  color: whitesmoke;
  transition: 0.3s;
  left: 0;
}
.spread-underline-selected {
  color: whitesmoke;
  /* text-decoration: underline; */
  /* text-underline-position: under; */
  bottom: 0;
  display: inline-block;
  margin-right: 20px;
  /* position: relative; */
  font-weight: bold;
  font-size: 18px;
}
/*가운데서 좌우로 펼쳐지는 라인 에니메이션:끝*/
</style>
