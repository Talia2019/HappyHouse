const Kakao = {
  init() {
    window.Kakao.init("da17ab51974602aad4f466bacd9024f3");
  },
  getMe(authObj) {
    console.log(authObj);
    window.Kakao.API.request({
      url: "http://localhost:8080/user/signup",
      success: async (res) => {
        console.log(res);
        const kakao_account = res.kakao_account;
        const req_body = {
          id: res.id,
          name: kakao_account.profile.nickname,
          email: kakao_account.email,
          kakaoAccessToken: authObj.access_token,
          source: "k",
        };
        social_login(req_body);
      },
      fail: (error) => {
        loginFailure();
        console.log(error);
      },
    });
  },
  login() {
    console.log(window.Kakao);
    window.Kakao.Auth.login({
      scope: "account_email",
      success: this.getMe,
      fail: logoutFailure,
    });
  },
  logout() {
    window.Kakao.Auth.logout((res) => {
      if (!res) return logoutFailure();
      social_logout();
    });
  },
};

export default Kakao;
