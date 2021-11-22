import Vue from "vue";
import Vuex from "vuex";
import http from "@/util/http-common.js";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

import boardStore from "@/store/modules/boardStore.js";
import memberStore from "@/store/modules/memberStore.js";

export default new Vuex.Store({
  state: {
    sidos: [{ value: null, text: "선택하세요" }],
    guguns: [{ value: null, text: "선택하세요" }],
    dongs: [{ value: null, text: "선택하세요" }],
    houses: [],
    house: null,
  },
  getters: {
    getLocation(state) {
      return state.houses;
    }
  },
  mutations: {
    SET_SIDO_LIST(state, sidos) {
      sidos.forEach((sido) => {
        state.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      });
    },
    SET_GUGUN_LIST(state, guguns) {
      guguns.forEach((gugun) => {
        state.guguns.push({ value: gugun.gugunCode, text: gugun.gugunName });
      });
    },
    SET_DONG_LIST(state, dongs) {
      dongs.forEach(dong => {
        state.dongs.push({ value: dong.dongCode, text: dong.dongName });
      })
    },
    SET_HOUSE_LIST(state, houses){
      state.houses = houses;
    }, 
    CLEAR_SIDO_LIST(state) {
      state.sidos = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_GUGUN_LIST(state) {
      state.guguns = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_DONG_LIST(state) {
      state.dongs = [{ value: null, text: "선택하세요 "}];
    },
    CLEAR_HOUSE_LIST(state) {
      state.houses = [];
    }
  },
  actions: {
    getSido({ commit }) {
      http.get("/map/sido").then((res) => {
        // console.log(res);
        commit("SET_SIDO_LIST", res.data);
      });
      const params = { gugun: "11110" };
      console.log(params);
      http
        .get("/map/dong", params)
        .then((res) => {
          console.log(res);
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
        .get("/map/dong", { params }).then((res) => {
          commit("SET_DONG_LIST", res.data);
        }).catch((err) => {
          console.log(err);
        })
    },
    getHouse({ commit }, code) {
      const dongCode = code.dongCode*1;
      const params = { gugun: code.gugunCode };
      http
        .get("/map/apt", { params }).then((res) => {
          // console.log(res.data.response.body.items.item, commit);
          const items = res.data.response.body.items.item;
          console.log(dongCode);
          console.log(items);
          const houseList = [];
          items.forEach(item => {
            if (item["법정동읍면동코드"] === dongCode){
              houseList.push(item);
            }
          });
          commit("SET_HOUSE_LIST", houseList);
        }).catch((err) => {
          console.log(err);
        })
    },
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
