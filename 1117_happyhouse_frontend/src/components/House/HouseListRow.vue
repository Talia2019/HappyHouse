<template>
<b-list-group-item @click="selectHouse"
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }">
  <b-row class="m-2">
    <b-col cols="10" class="align-self-center"> {{ house.아파트 }} : {{ house.거래금액 }} </b-col>
  </b-row>
</b-list-group-item>
</template>

<script>
import { mapActions } from 'vuex';
export default {
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
