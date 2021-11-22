<template>
<b-list-group-item @click="selectHouse"
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }">
  <b-row class="m-2">
    <b-col cols="10" class="align-self-center"><strong> {{ house.아파트 }} </strong></b-col>
  </b-row>
    <b-row ref="built" style="display: none;">
      <b-col>
        <b-alert show variant="light">건물노후 : {{ house.건축년도 | built }}년 </b-alert>
      </b-col>
    </b-row>
    <b-row ref="jibun" style="display: none;">
      <b-col>
        <b-alert show variant="primary">지번 : {{ house.지번 }} </b-alert>
      </b-col>
    </b-row>
    <b-row ref="floor" style="display: none;">
      <b-col>
        <b-alert show variant="info">층수 : {{ house.층 }}층 </b-alert>
      </b-col>
    </b-row>
    <b-row ref="time" style="display: none;">
      <b-col>
        <b-alert show variant="warning">계약년도/일 : {{ house.년 }}년 {{ house.월 }}월 {{ house.일 }}일</b-alert>
      </b-col>
    </b-row>
    <b-row ref="pay" style="display: none;">
      <b-col>
        <b-alert show variant="danger">거래금액 : {{ (parseInt(house.거래금액.replace(",", ""))) | price}} 만원</b-alert>
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
  filters: {
    price(value) {
      if (!value) return value;
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
    built(value) {
      if (!value) return value;
      return 2021 - parseInt(value);
    }
  },
  methods: {
    ...mapActions(["detailHouse"]),
    colorChange(flag) {
      this.isColor = flag;
    },
    selectHouse() {
      this.detailHouse(this.house);
      
      this.$emit("")
      let detail = [];
      detail.push(this.$refs.built);
      detail.push(this.$refs.jibun);
      detail.push(this.$refs.floor);
      detail.push(this.$refs.time);
      detail.push(this.$refs.pay);

      detail.forEach(tag => {
        if (tag.style.display == 'block') {
          tag.style.display = 'none';
        } else {
          tag.style.display = 'block';
        }
      })
    },
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
