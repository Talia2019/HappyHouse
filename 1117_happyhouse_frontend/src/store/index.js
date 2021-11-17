import Vue from 'vue'
import Vuex from 'vuex'
import http from '@/util/http-common.js';
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    sidos: [{ value: null, text: "선택하세요" }],
    guguns: [{ value: null, text: "선택하세요" }],
  },
  mutations: {
    SET_SIDO_LIST(state, sidos) {
      sidos.forEach(sido => {
        state.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      })
    },
    SET_GUGUN_LIST(state, guguns) {
      guguns.forEach(gugun => {
        state.guguns.push({ value: gugun.gugunCode, text: gugun.gugunName });
      })
    },
    CLEAR_SIDO_LIST(state) {
      state.sidos = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_GUGUN_LIST(state) {
      state.guguns = [{ value: null, text: "선택하세요" }];
    },
  },
  actions: {
    getSido({ commit }) {
      http
        .get("/map/sido").then((res) => {
          // console.log(res);
          commit("SET_SIDO_LIST", res.data);
        }).catch((err) => {
          console.log(err);
        })
    },
    getGugun({ commit }, sidoCode) {
      const params = { sido: sidoCode };
      http
        .get("/map/gugun", { params }).then((res) => {
          commit("SET_GUGUN_LIST", res.data);
        }).catch((err) => {
          console.log(err);
        })
    }
  },
  modules: {
  },
  plugins: [createPersistedState()],
})
