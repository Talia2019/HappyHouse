import axios from "axios";
// import VueCookies from "vue-cookies";

const kakaoHeader = {
  //admin
  Authorization: "d5321e3df3010ac1b3df17cc19b079e7",
  "Content-type": "application/x-www-form-urlencoded;charset=utf-8",
};

const getKakaoToken = async (code) => {
  console.log("loginWithKakao");
  try {
    const data = {
      grant_type: "authorization_code",
      // restAPI
      client_id: "614212d90899a7993f687a5fab4d7fb4",
      redirect_uri: "http://localhost:8080/dashboard",
      code: code,
    };
    const queryString = Object.keys(data)
      .map((k) => encodeURIComponent(k) + "=" + encodeURIComponent(data[k]))
      .join("&");
    const result = await axios.post(
      "https://kauth.kakao.com/oauth/token",
      queryString,
      { headers: kakaoHeader }
    );
    console.log("카카오 토큰");
    console.log(result);
    return result;
  } catch (e) {
    return e;
  }
};
const getKakaoUserInfo = async () => {
  let data = "";
  await window.Kakao.API.request({
    url: "/v2/user/me",
    success: function (response) {
      data = response;
    },
    fail: function (error) {
      console.log(error);
    },
  });
  // console.log("카카오 계정 정보", data);
  return data;
};

// const emailService = () => {
//   const emailLogin = async (email, password) => {
//     const data = {
//       email,
//       password,
//     };
//     try {
//       const { result } = (await axios.post("/emailLogin", data)).data;
//       VueCookies.set("access-token", result.access_token, "60s");
//       VueCookies.set("refresh-token", result.refresh_token, "3d");
//       console.log(result);
//       return result;
//     } catch (e) {
//       return e;
//     }
//   };
//   const test = async () => {
//     try {
//       const data = await axios.get("/testAPI");
//       console.log("API 성공");
//       return data;
//     } catch (e) {
//       console.log("API 실패");
//       return e;
//     }
//   };

//   return {
//     emailLogin,
//     test,
//   };
// };
// const refreshToken = async () => {
//   try {
//     const { result } = (await axios.get("/refreshToken")).data;
//     VueCookies.set("access-token", result.access_token);
//     console.log("Refresh API 성공", result);
//     return result;
//   } catch (e) {
//     console.log(e);
//   }
// };
export {
  getKakaoToken,
  getKakaoUserInfo,
  // getGoogleToken,
  // naverService,
  // emailService,
  // refreshToken,
};
