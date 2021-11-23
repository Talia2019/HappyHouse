<template>
  <card>
    <b-row align-v="center" slot="header">
      <b-col cols="8">
        <h3 class="mb-0">프로필 수정하기</h3>
      </b-col>
      <b-col cols="4" class="text-right">
        <!-- btn-sm  -->
        <b-button variant="primary" @click="updateProfile">수정</b-button>
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
              type="tel"
              label="전화번호"
              placeholder="전화번호"
              v-model="user.contact"
              @keyup="filterContact()"
            >
            </base-input>
          </b-col>
        </b-row>
        <b-row>
          <b-col md="12">
            <base-input
              type="password"
              label="비밀번호"
              placeholder="비밀번호"
              v-model="user.userpwd"
            >
            </base-input>
          </b-col>
        </b-row>
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
<script>
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";

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
    };
  },
  methods: {
    ...mapActions(memberStore, ["setUserInfo"]),
    async updateProfile() {
      this.user.username = this.username;
      console.log(this.user);
      await this.setUserInfo(this.user);
    },
    filterContact() {
      let p = this.user.contact;
      if (!p || !(p.length === 11)) return;
      p = p.replace(/^(\d{3})(\d{3,4})(\d{4})/g, "$1-$2-$3");
      this.user.contact = p;
      console.log(p);
    },
    // setUser() {
    //   this.user = this.userInfo;
    // },
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
  created() {
    this.user = this.userInfo;
    this.username = this.user.username;
    // console.log(this.user);
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
