<template>
  <card>
    <b-row align-v="center" slot="header">
      <b-col cols="8">
        <h3 class="mb-0">프로필 수정하기</h3>
      </b-col>
      <b-col cols="4" class="text-right">
        <!-- btn-sm  -->
        <b-button variant="primary" @click="updateProfile">수정</b-button>
        <b-button variant="primary" @click.prevent="deleteUser">탈퇴</b-button>
        <!-- <b-button variant="primary" @click.prevent="onClickLogout"
          >로그아웃</b-button
        > -->
      </b-col>
    </b-row>

    <div>
      <!-- <h6 class="heading-small text-muted mb-4">User information</h6> -->

      <!-- @ApiModelProperty(value = "회원 이름")
	private String username;
	@ApiModelProperty(value = "회원 비밀번호")
	private String userpwd;
	@ApiModelProperty(value = "회원 이메일")
	private String email;
	@ApiModelProperty(value = "회원 가입일")
	private String joindate; -->
      <div class="pl-lg-4">
        <b-row>
          <b-col lg="6">
            <base-input
              type="text"
              label="아이디"
              v-model="user.userid"
              disabled
            >
            </base-input>
          </b-col>
          <b-col lg="6">
            <base-input
              type="text"
              label="가입 날짜"
              v-model="user.joindate"
              disabled
            >
            </base-input>
          </b-col>
        </b-row>
        <b-row>
          <b-col lg="6">
            <base-input
              type="text"
              label="이름"
              placeholder="이름"
              v-model="username"
            >
            </base-input>
          </b-col>
          <b-col lg="6">
            <base-input
              id="email"
              type="email"
              label="이메일"
              placeholder="이메일"
              v-model="user.email"
            >
            </base-input>
          </b-col>
        </b-row>
      </div>
      <!-- <hr class="my-4" /> -->

      <!-- Address -->
      <!-- <h6 class="heading-small text-muted mb-4">Contact information</h6> -->

      <div class="pl-lg-4">
        <b-row>
          <b-col md="6">
            <base-input
              type="text"
              label="주소"
              placeholder="주소"
              v-model="user.address"
            >
            </base-input>
          </b-col>
          <b-col md="6">
            <base-input
              type="text"
              label="전화번호"
              placeholder="전화번호"
              v-model="contact"
              @keyup="getPhoneMask(contact)"
            >
            </base-input>
          </b-col>
        </b-row>
        <!-- <b-row>
          <b-col md="12">
            <base-input
              type="password"
              label="비밀번호"
              placeholder="비밀번호"
              v-model="user.userpwd"
            >
            </base-input>
          </b-col>
        </b-row> -->
        <!-- <b-row>
          <b-col lg="4">
            <base-input
              type="text"
              label="City"
              placeholder="City"
              v-model="user.city"
            >
            </base-input>
          </b-col>
          <b-col lg="4">
            <base-input
              type="text"
              label="Country"
              placeholder="Country"
              v-model="user.country"
            >
            </base-input>
          </b-col>
          <b-col lg="4">
            <base-input
              label="Postal Code"
              placeholder="ZIP Code"
              v-model="user.postalCode"
            >
            </base-input>
          </b-col>
        </b-row> -->
      </div>

      <!-- <hr class="my-4" /> -->
      <!-- Description -->
      <!-- <h6 class="heading-small text-muted mb-4">About me</h6>
      <div class="pl-lg-4">
        <b-form-group
          label="About Me"
          label-class="form-control-label"
          class="mb-0"
          label-for="about-form-textaria"
        > -->
      <!-- <label class="form-control-label">About Me</label> -->
      <!-- <b-form-textarea
            rows="4"
            value="A beautiful premium dashboard for BootstrapVue."
            id="about-form-textaria"
            placeholder="A few words about you ..."
          ></b-form-textarea>
        </b-form-group>
      </div> -->
    </div>
  </card>
</template>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
import { mapState, mapMutations, mapActions } from "vuex";
const memberStore = "memberStore";

import Swal from "sweetalert2/dist/sweetalert2.js";
import "sweetalert2/src/sweetalert2.scss";

export default {
  data() {
    return {
      // user: {
      //   company: "Creative Code Inc.",
      //   username: "michael23",
      //   email: "",
      //   firstName: "Mike",
      //   lastName: "Andrew",
      //   address: "Bld Mihail Kogalniceanu, nr. 8 Bl 1, Sc 1, Ap 09",
      //   city: "New York",
      //   country: "USA",
      //   postalCode: "",
      //   aboutMe: `Lamborghini Mercy, Your chick she so thirsty, I'm in that two seat Lambo.`,
      // },
      user: {},
      username: "",
      contact: "",
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo", "isLogin"]),
  },
  methods: {
    ...mapActions(memberStore, [
      "setUserInfo",
      "commentDelete",
      "boardDelete",
      "wishListDelete",
      "noticeDelete",
      "memberDelete",
    ]),
    async updateProfile() {
      const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
          confirmButton: "btn btn-success",
          cancelButton: "btn btn-danger",
        },
        buttonsStyling: false,
      });

      swalWithBootstrapButtons
        .fire({
          title: "정말로 수정하시겠습니까?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonText: "수정하기",
          cancelButtonText: "취소",
          reverseButtons: true,
        })
        .then((result) => {
          if (result.isConfirmed) {
            swalWithBootstrapButtons.fire("수정되었습니다!", "", "success");
            this.user.username = this.username;
            console.log(this.user);
            this.setUserInfo(this.user);
          } else if (
            /* Read more about handling dismissals below */
            result.dismiss === Swal.DismissReason.cancel
          ) {
            swalWithBootstrapButtons.fire("취소되었습니다!", "", "error");
          }
        });
    },
    filterContact() {
      let p = this.user.contact;
      if (!p || !(p.length < 11)) return;
      if (p.length > 11) p = p.substring(0, 11);
      p = p.replace(/^(\d{3})(\d{3,4})(\d{4})/g, "$1-$2-$3");
      this.user.contact = p;
      console.log(p);
    },
    // ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    // onClickLogout() {
    //   this.SET_IS_LOGIN(false);
    //   console.log(this.isLogin);
    //   this.SET_USER_INFO(null);
    //   sessionStorage.removeItem("access-token");
    // },
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    deleteUser() {
      const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
          confirmButton: "btn btn-success",
          cancelButton: "btn btn-danger",
        },
        buttonsStyling: false,
      });

      swalWithBootstrapButtons
        .fire({
          title: "정말로 탈퇴하시겠습니까?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonText: "탈퇴하기",
          cancelButtonText: "취소",
          reverseButtons: true,
        })
        .then((result) => {
          if (result.isConfirmed) {
            swalWithBootstrapButtons.fire("탈퇴되었습니다!", "", "success");
            setTimeout(() => {
              this.commentDelete(this.user.userid);
            }, 1000);
            setTimeout(() => {
              this.boardDelete(this.user.userid);
            }, 1000);
            setTimeout(() => {
              this.wishListDelete(this.user.userid);
            }, 1000);
            setTimeout(() => {
              this.noticeDelete(this.user.userid);
            }, 1000);
            setTimeout(() => {
              this.memberDelete(this.user.userid);
            }, 1000);
            setTimeout(() => {
              console.log(this.isLogin);
              this.SET_IS_LOGIN(false);
              console.log(this.isLogin);
              this.SET_USER_INFO(null);
              sessionStorage.removeItem("access-token");
              this.$router.push({ name: "dashboard" });
            }, 2000);
          } else if (
            /* Read more about handling dismissals below */
            result.dismiss === Swal.DismissReason.cancel
          ) {
            swalWithBootstrapButtons.fire("취소되었습니다!", "", "error");
          }
        });
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
  created() {
    this.user = this.userInfo;
    this.username = this.user.username;
    this.contact = this.user.contact;
    console.log(this.userInfo);
  },
  filters: {
    phone(value) {
      if (!value || !(value.length === 10 || value.length === 11)) return value;
      return value.replace(/^(\d{3})(\d{3,4})(\d{4})/g, "$1-$2-$3");
    },
  },
};
</script>
<style></style>
