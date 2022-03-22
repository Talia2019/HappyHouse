<template>
  <div>
    <div
      class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center profile-header"
      style="
        min-height: 400px;
        background-image: url(img/theme/profile-cover.jpg);
        background-size: cover;
        background-position: center top;
      "
    >
      <b-container fluid>
        <!-- Mask -->
        <span class="mask bg-gradient-success opacity-8"></span>
        <!-- Header container -->
        <b-container fluid class="d-flex align-items-center">
          <b-row>
            <b-col lg="7" md="10" style="min-width: 500px">
              <h1 class="display-2 text-white">
                Hello {{ userInfo.username }} <i class="ni ni-favourite-28"></i>
              </h1>
              <p class="text-white mt-0 mb-5">프로필을 자유롭게 수정하세요!</p>
              <!-- <a href="#!" class="btn btn-info">수정</a> -->
            </b-col>
          </b-row>
        </b-container>
      </b-container>
    </div>

    <b-container fluid class="mt--6">
      <b-row>
        <!-- <b-col xl="4" class="order-xl-2 mb-5">
          <user-card></user-card>
        </b-col> -->
        <b-col xl="12" class="order-xl-1">
          <edit-profile-form></edit-profile-form>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import EditProfileForm from "./UserProfile/EditProfileForm.vue";
import UserCard from "./UserProfile/UserCard.vue";
import { mapState } from "vuex";

const memberStore = "memberStore";

export default {
  components: {
    EditProfileForm,
    UserCard,
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
};
</script>
<style>
.bg-gradient-success {
  background: #2186c4 !important;
}
</style>
