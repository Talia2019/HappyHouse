<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-6 bg-gradient-success">
      <h1>부동산 실시간 거래정보</h1>
      <!-- <b-row align-h="end">
        <b-col cols="2">
          <b-form-select v-model="year" :options="years"></b-form-select>
        </b-col>
      </b-row> -->
      <b-row class="mt-4 mb-4 text-center">
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
    </base-header>

    <b-container fluid class="mt--7">
      <b-row>
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

export default {
  name: "HouseDeal",
  components: {
    HouseList,
    KakaoMap,
  },
  computed: {
    ...mapState(["sidos", "guguns", "dongs", "houses", "apts"]),
  },
  created() {
    this.CLEAR_SIDO_LIST();
    this.CLEAR_DEAL_LIST();
    this.sidoList();
  },
  data() {
    return {
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
      jibunCode: null,
      year: null,
      month: null,
    };
  },
  methods: {
    ...mapActions([
      "getSido",
      "getGugun",
      "getDong",
      "getHouse",
      "getOverlapHouse",
    ]),
    ...mapMutations([
      "CLEAR_SIDO_LIST",
      "CLEAR_GUGUN_LIST",
      "CLEAR_DONG_LIST",
      "CLEAR_HOUSE_LIST",
      "CLEAR_APT_LIST",
      "CLEAR_DEAL_LIST",
    ]),
    sidoList() {
      this.getSido();
    },
    gugunList() {
      console.log(this.sidoCode);
      this.CLEAR_GUGUN_LIST();
      this.gugunCode = null;
      if (this.sidoCode) this.getGugun(this.sidoCode);
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
      console.log(this.gugunCode.name, this.dongCode.name);
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
</style>
