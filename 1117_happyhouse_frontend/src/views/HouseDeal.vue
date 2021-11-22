<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
      <b-button variant="outline-primary">Button</b-button>
      <b-row class="mt-4 mb-4 text-center">
        <b-col class="sm-3">
          <b-form-select v-model="sidoCode" :options="sidos" @change="gugunList"></b-form-select>
        </b-col>
        <b-col class="sm-3">
          <b-form-select v-model="gugunCode" :options="guguns" @change="dongList"></b-form-select>
        </b-col>
        <b-col class="sm-3">
          <b-form-select v-model="dongCode" :options="dongs" @change="searchApt"></b-form-select>
        </b-col>
      </b-row>
    </base-header>
  
    <b-container fluid class="mt--7">
      <b-row>
        <b-col>
          <house-list />
        </b-col>
        <b-col>
          <b-card no-body class="border-0">
            <kakao-map/>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import HouseList from '@/components/House/HouseList.vue';
import KakaoMap from '@/components/House/KakaoMap.vue';
import { mapActions, mapMutations, mapState } from 'vuex';

  export default {
  name: "HouseDeal",
  components: {
    HouseList,
    KakaoMap,
  },
  computed: {
    ...mapState(["sidos", "guguns", "dongs", "houses"]),
  },
  created() {
    this.CLEAR_SIDO_LIST();
    this.sidoList();
  },
  data() {
    return {
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
    };
  },
  methods: {
    ...mapActions(["getSido", "getGugun", "getDong", "getHouse"]),
    ...mapMutations(["CLEAR_SIDO_LIST", "CLEAR_GUGUN_LIST", "CLEAR_DONG_LIST", "CLEAR_HOUSE_LIST"]),
    sidoList() {
      this.getSido();
    },
    gugunList() {
      console.log(this.sidoCode);
      this.CLEAR_GUGUN_LIST();
      this.gugunCode = null;
      if(this.sidoCode) this.getGugun(this.sidoCode);
    },
    dongList() {
      console.log(this.gugunCode);
      this.CLEAR_DONG_LIST();
      this.CLEAR_HOUSE_LIST();
      this.dongCode = null;
      if(this.gugunCode) this.getDong(this.gugunCode);
    },
    searchApt() {
      const code = { gugunCode: this.gugunCode, dongCode: this.dongCode.slice(5) };
      if(this.gugunCode) this.getHouse(code);
      if (this.houses.length != 0){
        this.findLocation();
      }
    },
    findLocation() {
      this.houses.forEach(house => {
        console.log(house);
      })
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.button-group {
  margin: 10px 0px;
}

button {
  margin: 0 3px;
}
.bg-success {
  background: #2186C4 !important;
}
/* .card {
  position: relative;
  top: 50px;
} */
</style>
