<template>
<b-list-group-item
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }">
  <b-row class="m-2">
    <b-img v-if="userInfo" id="star"
      @click="toggleStar"
      :src="star" 
      style="width:30px;height:30px;"></b-img>
    <b-col 
      @click="selectHouse"
      cols="10" 
      class="align-self-center"><strong> {{ house.아파트 }} </strong></b-col>
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
        <b-alert show variant="danger">거래금액 : {{ (parseInt(house.거래금액.replace(",", ""))) | price}}원</b-alert>
      </b-col>
    </b-row>
</b-list-group-item>
</template>

<script>
import { mapActions, mapMutations, mapState } from 'vuex';
import SideBar from '../SidebarPlugin/SideBar.vue';

const memberStore = "memberStore";

export default {
  components: { SideBar },
  name: "HouseListRow",
  data() {
    return {
      isColor: false,
      star: require("@/assets/img/gray.png"),
    };
  },
  props: {
    house: Object,
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
          resultString = String(" " + resultArray[i]) + unitWords[i] + resultString;
        }
        return resultString;
      }
    },
    built(value) {
      if (!value) return value;
      return 2021 - parseInt(value);
    }
  },
  created() {
    console.log('houselistrow creat!!!!')
    this.stars.forEach((star) => {
      if (star.houseName === this.house.아파트) {
        this.star = require("@/assets/img/star.png");
        return;
      } 
    })
  },
  updated() {
    console.log('houselistrow update!!!!')
    this.getStarHouse(this.userInfo.userid);
    var flag = false;
    this.stars.forEach((star) => {
      if (star.houseName === this.house.아파트) {
        this.star = require("@/assets/img/star.png");
        flag = true;
        return;
      }
    })
    if (!flag) {
      this.star = require("@/assets/img/gray.png");
    }
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    ...mapState(["stars", "addr"])
  },
  methods: {
    ...mapActions(["detailHouse", "checkStar", "unCheckStar", "getStarHouse", "putWishList"]),
    ...mapMutations(["SET_STAR_HOUSE_LIST"]),
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
    async toggleStar() {
      if (this.star.slice(5, 9) === 'star'){
        // this.star = require("@/assets/img/gray.png");
        const params = [this.house, this.userInfo.userid, this.addr] ;
        if (this.unCheckStar(params)) {
          await this.getStarHouse(this.userInfo.userid);
        }
      } else if (this.star.slice(5, 9) === 'gray') {
        // this.star = require("@/assets/img/star.png");
        const params = [this.house, this.userInfo.userid, this.addr] ;
        if (this.checkStar(params)) {
          await this.putWishList(params);
          await this.getStarHouse(this.userInfo.userid);
        }
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
