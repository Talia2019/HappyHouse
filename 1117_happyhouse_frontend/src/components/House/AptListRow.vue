<template>
<b-list-group-item>
    <b-row class="m-2">
      <b-col>
        계약일자 : {{ apt.년 }}.{{ apt.월 }}.{{ apt.일 }}
      </b-col>
    </b-row>
    <b-row class="m-2">
      <b-col>
        거래금액 : {{ (parseInt(apt.거래금액.replace(",", ""))) | price}}만원
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
    apt: Object,
  },
  filters: {
    price(value) {
      let inputNumber = value * 10000
      let unitWords = ['', '만', '억', '조', '경'];
      let splitUnit = 10000;
      let splitCount = unitWords.length;
      let resultArray = [];
      let resultString = '';

      if (!value) return value;
      else {
        for (let i = 0; i < splitCount; i++) {
          let unitResult = (inputNumber % Math.pow(splitUnit, i+1)) / Math.pow(splitUnit, i);
          unitResult = Math.floor(unitResult);
          if (unitResult > 0) {
            resultArray[i] = unitResult;
          }
        }

        for (let i = 0; i < resultArray.length; i++) {
          if(!resultArray[i]) continue;
          resultString = String(resultArray[i]) + unitWords[i] + resultString;
        }
        return resultString;
      }
    },
  },
  methods: {
    ...mapActions(["detailHouse"]),
    colorChange(flag) {
      this.isColor = flag;
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
