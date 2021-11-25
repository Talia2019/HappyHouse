import Vue from "vue";
import Vuex from "vuex";
import http from "@/util/http-common.js";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

import boardStore from "@/store/modules/boardStore.js";
import memberStore from "@/store/modules/memberStore.js";
import subwayStore from "@/store/modules/subwayStore.js";

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
    stars: [],
    addr: "",
    coords: null,
  },
  getters: {
    getLocation(state) {
      return state.houses;
    },
    getStar(state) {
      return state.stars;
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
      });
      state.apts = [{ value: null, text: "아파트" }];
      state.overlaps.forEach((over) => {
        state.apts.push({ value: over.지번, text: over.아파트 });
      });
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
        state.sidos.push({ 
          value: { code: sido.sidoCode, name: sido.sidoName },
          text: sido.sidoName
        });
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
      console.log("하우스");
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
    SET_STAR_HOUSE(state, houses) {
      state.stars = houses;
    },
    SET_STAR_HOUSE_LIST(state, stars) {
      state.selected = true;
      state.houses = [];
      stars.forEach((star) => {
        state.houses.push({
          아파트: star.houseName,
          건축년도: star.builtYear,
          거래금액: star.dealAmount,
          법정동: star.dongName,
          전용면적: star.area,
          지번: star.jibun,
          층: star.floor,
          년: star.dealYear,
          월: star.dealMonth,
          일: star.dealDay,
        });
      });
      console.log(state.houses);
    },
    SET_ADDRESS(state, addr) {
      state.addr = addr;
    },
    SET_COORDS(state, coords) {
      state.coords = coords;
    },
    CLEAR_SIDO_LIST(state) {
      state.sidos = [{ value: null, text: "시도" }];
    },
    CLEAR_GUGUN_LIST(state) {
      state.guguns = [{ value: null, text: "군구" }];
    },
    CLEAR_DONG_LIST(state) {
      state.dongs = [{ value: null, text: "읍면동" }];
    },
    CLEAR_HOUSE_LIST(state) {
      state.houses = [];
    },
    CLEAR_APT_LIST(state) {
      state.apts = [{ value: null, text: "아파트" }];
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
      http
        .get("/map/sido")
        .then((res) => {
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
      const dongCode = code.dongCode * 1;
      const params = { gugun: code.gugunCode.code, time: 202110 };
      console.log("map/apt");
      console.log(dongCode);
      console.log(params);
      http
        .get("/map/apt", { params })
        .then((res) => {
          console.log(res.data.response.body.items.item, commit);
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
    checkStar({ commit }, param) {
      const params = {
        houseName: param[0].아파트,
        dealAmount: param[0].거래금액,
        builtYear: param[0].건축년도,
        dealYear: param[0].년,
        dealMonth: param[0].월,
        dealDay: param[0].일,
        area: param[0].전용면적,
        floor: param[0].층,
        jibun: param[0].지번,
        dongName: param[0].법정동,
        houseCode: param[0].일련번호,
        houseDong: param[0].법정동 + " " + param[0].아파트,
        address: param[2],
        starCount: 1,
      };

      http
        .get("/map/check", { params }) // housedeal에 아파트가 등록되어 있는지 확인
        .then((res) => {
          console.log(res, commit);
          var size = res.data;
          if (size === 0) {
            http // 등록되어 있지 않으면 housedeal에 등록하기
              .post("/map/star", JSON.stringify(params))
              .then((res) => {
                console.log(commit, res);
              })
              .catch((err) => {
                console.log(err);
              });
          } else {
            // 등록되어 있으면 starCount +1 증가시키기
            http
              .put("/map/plus", JSON.stringify(params))
              .then((res) => {
                console.log(res);
              })
              .catch((err) => {
                console.log(err);
              });
          }
          return true;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    putWishList({ commit }, param) {
      const params1 = {
        userid: param[1],
        aptdong: param[0].법정동 + " " + param[0].아파트,
        address: param[2]
      };
      http
        .post("/map/userhouse", params1)
        .then((res) => {
          console.log(res, commit);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    // getStarHouse({ commit }, param) {
    //   const params = { userid: param };
    //   http.get("/map/starhouse", { params }).then((res) => {
    //     commit("SET_STAR_HOUSE", res.data);
    //   });
    // },
    getStarHouse({ commit }, param) {
      const params = { userid: param };
      http
        .get("/map/starhouse", { params })
        .then((res) => {
          commit("SET_STAR_HOUSE", res.data);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    unCheckStar({ commit }, param) {
      const params = {
        houseName: param[0].아파트,
        dealAmount: param[0].거래금액,
        builtYear: param[0].건축년도,
        dealYear: param[0].년,
        dealMonth: param[0].월,
        dealDay: param[0].일,
        area: param[0].전용면적,
        floor: param[0].층,
        jibun: param[0].지번,
        dongName: param[0].법정동,
        houseCode: param[0].일련번호,
        houseDong: param[0].법정동 + " " + param[0].아파트,
        address: param[2],
        starCount: 1,
      };
      // const params1 = { userid: param[1], aptcode: param[0].일련번호 };
      const userid = param[1];
      const aptdong = params.houseDong;
      http
        .put("/map/minus", JSON.stringify(params))
        .then((res) => {
          console.log(res, commit);
          http
            .delete(`/map/delete/${userid}&${aptdong}`)
            .then((res) => {
              console.log(res);
              return true;
            })
            .catch((err) => {
              console.log(err);
            });
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
  modules: {
    boardStore,
    memberStore,
    subwayStore,
  },
  plugins: [
    createPersistedState({
      // 브라우저 종료시 제거하기 위해 localStorage가 아닌 sessionStorage로 변경. (default: localStorage)
      storage: sessionStorage,
    }),
  ],
});
