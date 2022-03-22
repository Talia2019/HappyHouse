import { getList, getSubway, getGugunCode } from "@/api/subway.js";

const subwayStore = {
  namespaced: true,
  state: {
    subways: [{ value: null, text: "역명" }],
    subwayInfo: {},
    gugunCodeSub: null,
    isInfo: false,
  },
  getters: {},
  mutations: {
    // SET_LINE_LIST(state, lines) {
    //   lines.forEach((line) => {
    //     state.lines.push({ value: line.lineCode, text: line.lineName });
    //   });
    // },
    SET_SUBWAY_LIST(state, subways) {
      subways.forEach((subway) => {
        state.subways.push({
          value: subway,
          text: subway + "역",
        });
      });
    },
    SET_SUBWAY(state, subway) {
      state.subwayInfo = subway;
    },
    SET_GUGUN(state, gugun) {
      state.gugunCodeSub = gugun;
    },
    CLEAR_SUBWAY_LIST(state) {
      state.subways = [{ value: null, text: "역명" }];
    },
    SET_INFO(state, isInfo) {
      state.isInfo = isInfo;
    },
    // SET_INFO_ERROR(state) {
    //   state.isInfo = false;
    // },
  },
  actions: {
    clearSubwayList({ commit }) {
      commit("CLEAR_SUBWAY_LIST");
    },
    getSubwayList({ commit }, number) {
      getList(
        number,
        (response) => {
          // console.log("역리스트 성공");
          // console.log(response);
          commit("SET_SUBWAY_LIST", response.data);
        },
        (error) => {
          console.log("역리스트 실패");
          console.log(error);
        }
      );
    },
    async getSubwayInfo({ commit }, param) {
      const params = {
        number: param.number,
        name: param.name,
      };
      await getSubway(
        params,
        (response) => {
          if (response.data.message === "success") {
            // console.log(response.data);
            // console.log("역정보 성공");
            commit("SET_SUBWAY", response.data.subway);
            commit("SET_INFO", true);
          } else {
            // console.log("역정보 실패");
            commit("SET_INFO", false);
          }
        },
        (error) => {
          console.log("역정보 에러");
          commit("SET_INFO", false);
          console.log(error);
        }
      );
      // console.log("기다려");
    },
    async getGugunSubway({ commit }, name) {
      await getGugunCode(
        name,
        (response) => {
          // console.log("구군코드 성공");
          // console.log(response.data);
          commit("SET_GUGUN", response.data);
          commit("SET_INFO", true);
        },
        (error) => {
          console.log("구군코드 실패");
          commit("SET_INFO", false);
          console.log(error);
        }
      );
      // console.log("기다려22");
    },
    // getSido({ commit }) {
    //   http
    //     .get("/map/sido")
    //     .then((res) => {
    //       // console.log(res);
    //       commit("SET_SIDO_LIST", res.data);
    //     })
    //     .catch((err) => {
    //       console.log(err);
    //     });
    // },
    // getGugun({ commit }, sidoCode) {
    //   const params = { sido: sidoCode };
    //   http
    //     .get("/map/gugun", { params })
    //     .then((res) => {
    //       commit("SET_GUGUN_LIST", res.data);
    //     })
    //     .catch((err) => {
    //       console.log(err);
    //     });
    // },
  },
};

export default subwayStore;
