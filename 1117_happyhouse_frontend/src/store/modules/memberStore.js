import jwt_decode from "jwt-decode";
import {
  login,
  findById,
  updateMember,
  registerMember,
  deleteComment,
  deleteBoard,
  deleteWishList,
  deleteNotice,
  deleteMember,
  idCheck,
} from "@/api/member.js";

const memberStore = {
  namespaced: true,
  state: {
    idckstate: false,
    isLogin: false,
    isLoginError: false,
    userInfo: null,
  },
  getters: {
    checkUserInfo: function (state) {
      return state.userInfo;
    },
  },
  mutations: {
    SET_ID_CHECK_SUCCESS: (state) => {
      state.idckstate = "중복된 ID입니다.";
      // state.idckstate = true;
    },
    SET_ID_CHECK_FAIL: (state) => {
      state.idckstate = "생성가능한 ID입니다.";
      // state.idckstate = false;
    },
    SET_IS_LOGIN: (state, isLogin) => {
      state.isLogin = isLogin;
    },
    SET_IS_LOGIN_ERROR: (state, isLoginError) => {
      state.isLoginError = isLoginError;
    },
    SET_USER_INFO: (state, userInfo) => {
      state.isLogin = true;
      state.userInfo = userInfo;
    },
  },
  actions: {
    async userConfirm({ commit }, user) {
      await login(
        user,
        (response) => {
          if (response.data.message === "success") {
            let token = response.data["access-token"];
            commit("SET_IS_LOGIN", true);
            commit("SET_IS_LOGIN_ERROR", false);
            sessionStorage.setItem("access-token", token);
          } else {
            commit("SET_IS_LOGIN", false);
            commit("SET_IS_LOGIN_ERROR", true);
          }
        },
        () => {}
      );
    },
    getUserInfo({ commit }, token) {
      let decode_token = jwt_decode(token);
      findById(
        decode_token.userid,
        (response) => {
          if (response.data.message === "success") {
            commit("SET_USER_INFO", response.data.userInfo);
          } else {
            console.log("유저 정보 없음!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    setUserInfo({ commit }, user) {
      updateMember(
        user,
        (response) => {
          console.log(response);
          if (response.data === "success") {
            commit("SET_USER_INFO", user);
          } else {
            console.log("수정 실패");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    setRegister({ commit }, user) {
      registerMember(
        user,
        (response) => {
          if (response.data === "success") {
            commit("SET_USER_INFO", user);
          } else {
            console.log("회원가입 실패!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    commentDelete({ commit }, user) {
      deleteComment(
        user,
        (response) => {
          if (response.data === "success") {
            commit("SET_USER_INFO", user);
          } else {
            console.log("회원 탈퇴 실패!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    boardDelete({ commit }, user) {
      deleteBoard(
        user,
        (response) => {
          if (response.data === "success") {
            commit("SET_USER_INFO", user);
          } else {
            console.log("회원 탈퇴 실패!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    wishListDelete({ commit }, user) {
      deleteWishList(
        user,
        (response) => {
          if (response.data === "success") {
            commit("SET_USER_INFO", user);
          } else {
            console.log("회원 탈퇴 실패!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    noticeDelete({ commit }, user) {
      deleteNotice(
        user,
        (response) => {
          if (response.data === "success") {
            commit("SET_USER_INFO", user);
          } else {
            console.log("회원 탈퇴 실패!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    memberDelete({ commit }, user) {
      deleteMember(
        user,
        (response) => {
          if (response.data === "success") {
            commit("SET_USER_INFO", user);
          } else {
            console.log("회원 탈퇴 실패!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },

    ckId({ commit }, user) {
      idCheck(
        user,
        (response) => {
          if (response.data === "success") {
            console.log(response.data);
            console.log("ID 중복");
            commit("SET_ID_CHECK_SUCCESS", user);
          } else {
            console.log("ID 사용가능");
            commit("SET_ID_CHECK_FAIL", user);
          }
        },
        (error) => {
          console.log(error);
          console.log("에러발생");
        }
      );
    },
  },
};

export default memberStore;
