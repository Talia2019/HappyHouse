import Vue from "vue";
import Vuex from "vuex";
import http from "@/util/http-common.js";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

import boardStore from "@/store/modules/boardStore.js";
import memberStore from "@/store/modules/memberStore.js";

export default new Vuex.Store({
  state: {
    sidos: [{ value: null, text: "시도" }],
    guguns: [{ value: null, text: "군구" }],
    dongs: [{ value: null, text: "읍면동" }],
    houses: [],
    overlaps: [],
    house: null,
    flag: false,
    selected: false,
    apts: [{ value: null, text: "아파트" }],
    aptLists: [],
    gudong: null,
  },
  getters: {
    getLocation(state) {
      return state.houses;
    },
    overlapHouse(state) {
      state.overlaps = [];
      state.houses.forEach((house) => {
        state.flag = false;
        for (let i = 0; i < state.overlaps.length; i++) {
          if (house["아파트"] === state.overlaps[i]["아파트"]) {
            if (
              house["거래금액"].replace(",", "") * 1 >
              state.overlaps[i]["거래금액"].replace(",", "") * 1
            ) {
              state.overlaps[i] = house;
            }
            state.flag = true;
          }
        }
        if (!state.flag) {
          state.overlaps.push(house);
        }
      });
      state.overlaps.sort((a, b) => {
        return a["아파트"] < b["아파트"] ? -1 : a["아파트"] > b["아파트"] ? 1 : 0;
      })
      state.apts = [{ value: null, text: "아파트" }];
      state.overlaps.forEach(over => {
        state.apts.push({ value: over.지번, text: over.아파트 })
      })
      return state.overlaps;
    },
    getAptList(state) {
      return state.aptLists;
    },
    moveCenter(state) {
      return state.gudong;
    },
  },
  mutations: {
    SET_SIDO_LIST(state, sidos) {
      sidos.forEach((sido) => {
        state.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      });
    },
    SET_GUGUN_LIST(state, guguns) {
      guguns.forEach((gugun) => {
        state.guguns.push({
          value: { code: gugun.gugunCode, name: gugun.gugunName },
          text: gugun.gugunName,
        });
      });
    },
    SET_DONG_LIST(state, dongs) {
      dongs.forEach((dong) => {
        state.dongs.push({
          value: { code: dong.dongCode, name: dong.dongName },
          text: dong.dongName,
        });
      });
    },
    SET_HOUSE_LIST(state, houses) {
      state.selected = true;
      state.houses = houses;
    },
    SET_DETAIL_HOUSE(state, house) {
      state.house = house;
    },
    SET_OVERLAP_LIST(state, aptList) {
      state.selected = false;
      state.aptLists = aptList;
    },
    CLEAR_SIDO_LIST(state) {
      state.sidos = [{ value: null, text: "시도" }];
    },
    CLEAR_GUGUN_LIST(state) {
      state.guguns = [{ value: null, text: "군구" }];
    },
    CLEAR_DONG_LIST(state) {
      state.dongs = [{ value: null, text: "읍면동"}];
    },
    CLEAR_HOUSE_LIST(state) {
      state.houses = [];
    },
    CLEAR_APT_LIST(state) {
      state.apts = [{ value: null, text: "아파트"}];
    },
    CLEAR_DEAL_LIST(state) {
      state.aptLists = [];
    },
    MOVE_CENTER(state, gudongName) {
      state.gudong = gudongName;
    },
  },
  actions: {
    getSido({ commit }) {
      http.get("/map/sido").then((res) => {
        // console.log(res);
        commit("SET_SIDO_LIST", res.data);
      })
      .catch((err) => {
        console.log(err);
      });
    },
    getGugun({ commit }, sidoCode) {
      const params = { sido: sidoCode };
      http
        .get("/map/gugun", { params })
        .then((res) => {
          commit("SET_GUGUN_LIST", res.data);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getDong({ commit }, gugunCode) {
      const params = { gugun: gugunCode };
      http
        .get("/map/dong", { params })
        .then((res) => {
          commit("SET_DONG_LIST", res.data);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getHouse({ commit }, code) {
      const dongCode = code.dongCode*1;
      const params = { gugun: code.gugunCode.code, time: 202110 };
      http
        .get("/map/apt", { params })
        .then((res) => {
          // console.log(res.data.response.body.items.item, commit);
          const items = res.data.response.body.items.item;
          const houseList = [];
          items.forEach((item) => {
            if (item["법정동읍면동코드"] === dongCode) {
              houseList.push(item);
            }
          });
          if (houseList.length == 0) {
            commit("MOVE_CENTER", code.gudongName);
          }
          commit("SET_HOUSE_LIST", houseList);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    detailHouse({ commit }, house) {
      commit("SET_DETAIL_HOUSE", house);
    },
    getOverlapHouse({ commit, state }, jibunCode) {
      const aptList = [];
      state.houses.forEach((house) => {
        if (house.지번 === jibunCode) {
          aptList.push(house);
        }
      });
      commit("SET_OVERLAP_LIST", aptList);
    },
    checkStar({ commit }, house) {
      const params = { houseName: house.아파트, dealAmount: house.거래금액, dealYear: house.년, dealMonth: house.월, dealDay: house.일, area: house.전용면적, floor: house.층, jibun: house.지번, dongName: house.법정동, starCount: 1 }
      http
        .post("/map/star", JSON.stringify(params)).then((res) => {
          console.log(commit, res);
        }).catch((err) => {
          console.log(err);
        })
    }
  },
  modules: {
    boardStore,
    memberStore,
  },
  plugins: [
    createPersistedState({
      // 브라우저 종료시 제거하기 위해 localStorage가 아닌 sessionStorage로 변경. (default: localStorage)
      storage: sessionStorage,
    }),
  ],
});
