<template>
  <div>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg
          x="0"
          y="0"
          viewBox="0 0 2560 100"
          preserveAspectRatio="none"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
        >
          <polygon
            class="fill-default"
            points="2560 0 2560 100 0 100"
          ></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <b-container class="mt--8 pb-5">
      <!-- Table -->
      <b-row class="justify-content-center">
        <b-col lg="6" md="8">
          <b-card no-body class="bg-secondary border-0">
            <div class="text-muted text-center mt-5 mb-4">
              <h2>Regist</h2>
            </div>
            <!-- <div class="text-center">
              <base-button
                type="warning"
                variant="warning"
                class="my-1"
                @click="loginWithKakao()"
                >Kakao account</base-button
              >
            </div> -->
            <div class="text-center"></div>
            <b-card-body class="px-lg-5 py-lg-5">
              <validation-observer
                v-slot="{ handleSubmit }"
                ref="formValidator"
              >
                <b-form role="form" @submit.prevent="handleSubmit(onSubmit)">
                  <base-input
                    v-if="false"
                    alternative
                    class="mb-3"
                    placeholder="Id 중복여부"
                    id="check"
                    v-model="user.idck"
                    readonly
                  >
                  </base-input>

                  <b-button
                    variant="primary"
                    @click="idcheck"
                    class="btn float-right"
                    >ID 중복체크</b-button
                  >

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-single-02 text-red"
                    placeholder="Id"
                    id="userid"
                    :rules="{ required: true }"
                    v-model="user.userid"
                  >
                  </base-input>

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-tag text-red"
                    placeholder="Name"
                    id="username"
                    :rules="{ required: true }"
                    v-model="user.username"
                  >
                  </base-input>

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-email-83 text-red"
                    placeholder="Email"
                    id="email"
                    :rules="{ required: true, email: true }"
                    v-model="user.email"
                  >
                  </base-input>

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-lock-circle-open text-red"
                    placeholder="password"
                    type="password"
                    id="userpwd"
                    :rules="{ required: true, min: 6 }"
                    v-model="user.userpwd"
                  >
                  </base-input>
                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-square-pin"
                    placeholder="address"
                    type="text"
                    id="address"
                    v-model="user.address"
                  >
                  </base-input>
                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-mobile-button"
                    placeholder="contact"
                    type="tel"
                    :rules="{ max: 13 }"
                    id="contact"
                    v-model="contact"
                    @keyup="getPhoneMask(contact)"
                  >
                  </base-input>
                  <div class="text-center">
                    <div class="text-center">
                      <base-button
                        type="primary"
                        variant="primary"
                        class="my-4"
                        @click="confirm"
                        >계정 생성
                      </base-button>
                    </div>
                  </div>
                </b-form>
              </validation-observer>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
//import { registerMember } from "@/api/member";
import { mapState, mapActions } from "vuex";
const memberStore = "memberStore";

import Swal from "sweetalert2/dist/sweetalert2.js";
import "sweetalert2/src/sweetalert2.scss";

export default {
  name: "Register",
  data() {
    return {
      user: {
        userid: null,
        username: null,
        userpwd: null,
        email: null,
        idck: null,
        address: null,
        contact: null,
      },
      contact: null,
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError", "idckstate"]),
  },
  methods: {
    ...mapActions(memberStore, ["setRegister", "ckId"]),

    async confirm() {
      if (
        this.user.idck == "생성가능한 ID입니다." &&
        this.user.username != null &&
        this.user.email != null &&
        this.user.userpwd != null &&
        this.user.userpwd.length >= 6
      ) {
        this.setRegister(this.user);
        // alert("가입을 축하드립니다.");
        Swal.fire({
          position: "top-end",
          icon: "success",
          title: "정상적으로 가입되었습니다!",
          showConfirmButton: false,
          timer: 1500,
        });
        this.$router.push({ name: "dashboard" });
      } else if (this.user.idck == "중복된 ID입니다.") {
        // alert("새로운 ID를 입력해주세요.");
        Swal.fire({
          icon: "error",
          title: "새로운 ID를 입력해주세요.",
        });
      } else if (this.user.username == null) {
        // alert("이름을 입력해주세요.");
        Swal.fire({
          icon: "error",
          title: "이름을 입력해주세요.",
        });
      } else if (this.user.email == null) {
        // alert("이메일을 입력해주세요.");
        Swal.fire({
          icon: "error",
          title: "이메일을 입력해주세요.",
        });
      } else if (this.user.userpwd == null) {
        // alert("비밀번호를 입력해주세요.");
        Swal.fire({
          icon: "error",
          title: "비밀번호를 입력해주세요.",
        });
      } else if (this.user.userpwd.length < 6) {
        // alert("비밀번호를 입력해주세요.");
        Swal.fire({
          icon: "error",
          title: "6자 이상의 비밀번호를 입력해주세요.",
        });
      } else {
        // alert("ID 중복체크 버튼을 눌러 중복여부를 확인해주세요.");
        Swal.fire({
          icon: "error",
          title: "ID 중복체크 버튼을 눌러 중복여부를 확인해주세요.",
        });
      }
    },

    loginWithKakao() {
      const params = {
        redirectUri: "http://localhost:8080/dashboard",
      };
      window.Kakao.Auth.authorize(params);
    },

    async idcheck() {
      if (this.user.userid != null) {
        this.ckId(this.user.userid);
        console.log(this.idckstate);
        setTimeout(() => {
          this.user.idck = this.idckstate;
          if (this.user.idck == "생성가능한 ID입니다.") {
            Swal.fire({
              icon: "success",
              title: "생성가능한 ID입니다.",
            });
          } else {
            Swal.fire({
              icon: "error",
              title: "중복된 ID입니다.",
            });
          }
        }, 1000);
      } else {
        // alert("ID를 입력해주세요.");
        Swal.fire({
          icon: "error",
          title: "ID를 입력해주세요.",
        });
      }
    },
    getPhoneMask(val) {
      let res = this.getMask(val);
      this.contact = res;
      this.user.contact = res;
      //서버 전송 값에는 '-' 를 제외하고 숫자만 저장
      // this.model.contact = this.contact.replace(/[^0-9]/g, "");
    },

    getMask(phoneNumber) {
      if (!phoneNumber) return phoneNumber;
      phoneNumber = phoneNumber.replace(/[^0-9]/g, "");
      let res = "";
      if (phoneNumber.length < 3) {
        res = phoneNumber;
        console.log(res);
      } else {
        if (phoneNumber.substr(0, 2) == "02") {
          if (phoneNumber.length <= 5) {
            //02-123-5678
            res = phoneNumber.substr(0, 2) + "-" + phoneNumber.substr(2, 3);
          } else if (phoneNumber.length > 5 && phoneNumber.length <= 9) {
            //02-123-5678
            res =
              phoneNumber.substr(0, 2) +
              "-" +
              phoneNumber.substr(2, 3) +
              "-" +
              phoneNumber.substr(5);
          } else if (phoneNumber.length > 9) {
            //02-1234-5678
            res =
              phoneNumber.substr(0, 2) +
              "-" +
              phoneNumber.substr(2, 4) +
              "-" +
              phoneNumber.substr(6);
          }
        } else {
          if (phoneNumber.length < 8) {
            res = phoneNumber;
          } else if (phoneNumber.length == 8) {
            res = phoneNumber.substr(0, 4) + "-" + phoneNumber.substr(4);
          } else if (phoneNumber.length == 9) {
            res =
              phoneNumber.substr(0, 3) +
              "-" +
              phoneNumber.substr(3, 3) +
              "-" +
              phoneNumber.substr(6);
          } else if (phoneNumber.length == 10) {
            res =
              phoneNumber.substr(0, 3) +
              "-" +
              phoneNumber.substr(3, 3) +
              "-" +
              phoneNumber.substr(6);
          } else if (phoneNumber.length > 10) {
            //010-1234-5678
            res =
              phoneNumber.substr(0, 3) +
              "-" +
              phoneNumber.substr(3, 4) +
              "-" +
              phoneNumber.substr(7);
          }

          if (res.length > 13) {
            res = res.substr(0, 13);
          }
        }
      }
      return res;
    },
  },
};
</script>
<style>
.bg-gradient-success {
  background: #2186c4 !important;
}
</style>
