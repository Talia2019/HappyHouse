<template>
  <div>
    <base-header class="pb-4 pt-5 pt-md-6 bg-gradient-success">
      <h1>부동산 실시간 거래정보</h1>
      <div class="ml-3 mt-1 mb-3" style="float: left;">
        <span :class="firstClass" @click="sigudong()">시/구/동</span>
        <span :class="secondClass" @click="subway()">지하철역</span>
        <!-- <hr style="border: solid; height: 3px background: #ccc;" /> -->
      </div>
      <b-row align-h="end">
        <b-button @click="starHouseList" style="background-color: #2186c4;">
          <b-img
            :src="require('@/assets/img/star.png')"
            style="width: 30px; height: 30px;"
          ></b-img>
        </b-button>
      </b-row>
      <b-row class="mt-4 mb-4 text-center" v-if="isSiGuDong">
        <b-col class="sm-3">
          <b-form-select
            v-model="sidoCode"
            :options="sidos"
            @change="gugunList"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3">
          <b-form-select
            v-model="gugunCode"
            :options="guguns"
            @change="dongList"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3" @click="getDongName">
          <b-form-select
            v-model="dongCode"
            :options="dongs"
            @change="searchApt"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3">
          <b-form-select
            v-model="jibunCode"
            :options="apts"
            @change="aptList"
          ></b-form-select>
        </b-col>
      </b-row>

      <!-- subway select -->
      <b-row class="mt-4 mb-4 text-center" v-if="!isSiGuDong">
        <b-col class="sm-3">
          <b-form-select
            v-model="lineCode"
            :options="lines"
            @change="subwayList"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3">
          <b-form-select
            v-model="subwayName"
            :options="subways"
            @change="[searchSubway(), searchApt()]"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3">
          <b-form-select
            v-model="jibunCode"
            :options="apts"
            @change="aptList"
          ></b-form-select>
        </b-col>
        <b-col class="sm-3">
          <div>
            <span class="spread-underline-selected">{{ locationdesc }}</span>
            <!-- <hr style="border: solid; height: 3px background: #ccc;" /> -->
          </div>
        </b-col>
      </b-row>
    </base-header>

    <b-container fluid>
      <b-row class="mt-4">
        <b-col>
          <house-list />
        </b-col>
        <b-col>
          <b-card no-body class="border-0">
            <kakao-map />
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import HouseList from "@/components/House/HouseList.vue";
import KakaoMap from "@/components/House/KakaoMap.vue";
import { mapActions, mapMutations, mapState } from "vuex";
const memberStore = "memberStore";
const subwayStore = "subwayStore";

export default {
  name: "HouseDeal",
  components: {
    HouseList,
    KakaoMap,
  },
  computed: {
    ...mapState(subwayStore, [
      "subways",
      "subwayInfo",
      "gugunCodeSub",
      "isInfo",
    ]),
    ...mapState(["sidos", "guguns", "dongs", "houses", "apts", "stars", "addr"]),
    ...mapState(memberStore, ["userInfo"]),
  },
  created() {
    this.CLEAR_SIDO_LIST();
    this.CLEAR_DEAL_LIST();
    this.sidoList();
    this.getStarHouse(this.userInfo.userid);
    // this.clearSubwayList();
  },
  data() {
    return {
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
      jibunCode: null,
      year: null,
      month: null,
      firstClass: "spread-underline-selected",
      secondClass: "spread-underline",
      isSiGuDong: true,
      locationdesc: "",
      lineCode: null,
      subwayName: null,
      lines: [
        { value: null, text: "노선" },
        { value: 1, text: "1호선" },
        { value: 2, text: "2호선" },
        { value: 3, text: "3호선" },
        { value: 4, text: "4호선" },
        { value: 5, text: "5호선" },
        { value: 6, text: "6호선" },
        { value: 7, text: "7호선" },
        { value: 8, text: "8호선" },
        { value: 9, text: "9호선" },
      ],
    };
  },
  methods: {
    ...mapActions(subwayStore, [
      "getSubwayList",
      "clearSubwayList",
      "getSubwayInfo",
      "getGugunSubway",
    ]),
    ...mapActions([
      "getSido",
      "getGugun",
      "getDong",
      "getHouse",
      "getOverlapHouse",
      "getStarHouse",
    ]),
    ...mapMutations([
      "CLEAR_SIDO_LIST",
      "CLEAR_GUGUN_LIST",
      "CLEAR_DONG_LIST",
      "CLEAR_HOUSE_LIST",
      "CLEAR_APT_LIST",
      "CLEAR_DEAL_LIST",
      "SET_STAR_HOUSE_LIST",
      "SET_ADDRESS"
    ]),
    subwayList() {
      this.clearSubwayList();
      this.subwayCode = null;
      if (this.lineCode) this.getSubwayList(this.lineCode);
    },
    async searchSubway() {
      console.log(this.lineCode + " " + this.subwayName);
      let param = {
        number: this.lineCode,
        name: this.subwayName,
      };

      await this.getSubwayInfo(param);
      await this.getGugunSubway(this.subwayInfo.gugunname);
      this.gugunCode = {
        code: this.gugunCodeSub,
        name: this.subwayInfo.gugunname,
      };
      this.dongCode = {
        code: this.subwayInfo.dongcode,
        name: this.subwayInfo.dongname,
      };

      if (this.subwayInfo.sidoname != "경기도") {
        this.locationdesc =
          this.subwayInfo.sidoname +
          " " +
          this.subwayInfo.gugunname +
          " " +
          this.subwayInfo.dongname;
        this.searchApt();
      } else {
        this.locationdesc = "경기도 미지원 중입니다.";
      }
    },
    sidoList() {
      this.getSido();
      this.gugunCode = null;
    },
    gugunList() {
      console.log(this.sidoCode.code);
      this.CLEAR_GUGUN_LIST();
      this.gugunCode = null;
      this.jibunCode = null;
      if (this.sidoCode.code) this.getGugun(this.sidoCode.code);
    },
    dongList() {
      this.CLEAR_DONG_LIST();
      this.CLEAR_HOUSE_LIST();
      this.CLEAR_APT_LIST();
      this.CLEAR_DEAL_LIST();
      this.dongCode = null;
      this.jibunCode = null;
      if (this.gugunCode.code) this.getDong(this.gugunCode.code);
    },
    searchApt() {
      var addr = this.sidoCode.name + " " + this.gugunCode.name + " " + this.dongCode.name;
      this.SET_ADDRESS(addr);
      console.log(this.addr);
      const code = {
        gugunCode: this.gugunCode,
        dongCode: this.dongCode.code.slice(5),
        gudongName: this.gugunCode.name + " " + this.dongCode.name,
      };
      this.CLEAR_APT_LIST();
      this.jibunCode = null;
      if (this.gugunCode.code) this.getHouse(code);
    },
    aptList() {
      this.CLEAR_APT_LIST();
      this.CLEAR_DEAL_LIST();
      this.getOverlapHouse(this.jibunCode);
    },
    getDongName(val) {
      console.log(val);
    },
    starHouseList() {
      console.log(this.stars);
      this.SET_STAR_HOUSE_LIST(this.stars);
    },
    sigudong: function() {
      var _this = this;
      // this.$router.replace({ name: "card", params: { type: "board" } });
      this.firstClass = "spread-underline-selected";
      this.secondClass = "spread-underline";
      this.isSiGuDong = true;
      this.CLEAR_SIDO_LIST();
      this.sidoCode = null;
      _this.sidoList();
      this.CLEAR_DONG_LIST();
      this.CLEAR_HOUSE_LIST();
      this.CLEAR_APT_LIST();
      this.CLEAR_DEAL_LIST();
    },
    subway() {
      this.secondClass = "spread-underline-selected";
      this.firstClass = "spread-underline";
      this.isSiGuDong = false;
      this.clearSubwayList();
      this.locationdesc = "";
      this.lineCode = null;
      this.CLEAR_GUGUN_LIST();
      this.CLEAR_DONG_LIST();
      this.CLEAR_HOUSE_LIST();
      this.CLEAR_APT_LIST();
      this.CLEAR_DEAL_LIST();
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.button-group {
  margin: 10px 0px;
}

button {
  margin: 0 3px;
}
.bg-success {
  background: #2186c4 !important;
}
/* .card {
  position: relative;
  top: 50px;
} */
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
</style>
