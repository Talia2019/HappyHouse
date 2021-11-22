<template>
  <div>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <b-container class="container">
        <div class="header-body text-center mb-7">
          <b-row class="justify-content-center">
            <b-col xl="5" lg="6" md="8" class="px-5">
              <h1 class="text-white">Create an account</h1>
              <p class="text-lead text-white">
                Use these awesome forms to login or create new account in your
                project for free.
              </p>
            </b-col>
          </b-row>
        </div>
      </b-container>
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
            <div class="text-muted text-center mt-2 mb-4">
              <h2>Regist</h2>
            </div>
            <b-card-body class="px-lg-5 py-lg-5">
              <validation-observer
                v-slot="{ handleSubmit }"
                ref="formValidator"
              >
                <b-form role="form" @submit.prevent="handleSubmit(onSubmit)">
                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-hat-3"
                    placeholder="Id"
                    id="userid"
                    :rules="{ required: true }"
                    v-model="user.userid"
                  >
                  </base-input>

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-hat-3"
                    placeholder="Name"
                    id="username"
                    :rules="{ required: true }"
                    v-model="user.username"
                  >
                  </base-input>

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-email-83"
                    placeholder="Email"
                    id="email"
                    :rules="{ required: true, email: true }"
                    v-model="user.email"
                  >
                  </base-input>

                  <base-input
                    alternative
                    class="mb-3"
                    prepend-icon="ni ni-lock-circle-open"
                    placeholder="password"
                    type="password"
                    id="userpwd"
                    :rules="{ required: true, min: 6 }"
                    v-model="user.userpwd"
                  >
                  </base-input>
                  <div class="text-center">
                    <b-button type="submit" variant="primary" class="mt-4"
                      >Create account</b-button
                    >
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
<script>
import { registerMember } from "@/api/member";
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";

export default {
  name: "Register",
  data() {
    return {
      user: {
        userid: null,
        username: null,
        userpwd: null,
        email: null,
      },
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError"]),
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo"]),
    onSubmit(event) {
      event.preventDefault();
      registerMember();
    },
    registerMember() {
      registerMember(
        {
          userid: this.user.userid,
          username: this.user.username,
          userpwd: this.user.userpwd,
          email: this.user.email,
        },
        ({ data }) => {
          // let msg = "등록 처리시 문제가 발생했습니다.";
          if (data === "success") {
            // msg = "등록이 완료되었습니다.";
          }
          // alert(msg);
          this.moveList();
        },
        (error) => {
          console.log(error);
        }
      );
    },
  },
};
</script>
<style>
.bg-gradient-success {
  background: #2186c4 !important;
}
</style>
