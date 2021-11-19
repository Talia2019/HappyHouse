<template>
<b-list-group-item @click="selectHouse"
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }">
  <b-row class="m-2">
    <b-col @click="getDetail" cols="10" class="align-self-center"> {{ house.아파트 }} : {{ house.거래금액 }} </b-col>
    <b-col class="align-self-center detail" style="display:none"> {{ house.전용면적 }}</b-col>
  </b-row>
  <b-row>
      <b-col>
        <b-alert show variant="secondary">일련번호 :{{ house.일련번호 }}</b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-alert show variant="primary">아파트 이름 : {{ house.아파트 }} </b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-alert show variant="info">법정동 : {{ house.법정동 }} </b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-alert show variant="warning">층수 : {{ house.층 }}층</b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-alert show variant="danger">거래금액 : {{ (parseInt(house.거래금액.replace(",", "")) * 10000) | price }}원</b-alert>
      </b-col>
    </b-row>
</b-list-group-item>
</template>

<script>
import { mapActions } from 'vuex';
import SideBar from '../SidebarPlugin/SideBar.vue';

export default {
  components: { SideBar },
  name: "HouseListRow",
  data() {
    return {
      isColor: false,
    };
  },
  props: {
    house: Object,
  },
  methods: {
    ...mapActions(["detailHouse"]),
    colorChange(flag) {
      this.isColor = flag;
    },
    selectHouse() {
      this.detailHouse(this.house);
    },
    getDetail() {
      let detail = document.querySelector('.detail');

      if (detail.style.display == 'block') {
        detail.style.display = 'none';
      } else {
        detail.style.display = 'block';
      } 
    }
  },
};
</script>

<style scoped>
.apt {
  width: 50px;
}
.mouse-over-bgcolor {
  background-color: lightblue;
}
.list-group-item {
  padding-top: 10px;
  padding-bottom: 10px;
}
</style>
