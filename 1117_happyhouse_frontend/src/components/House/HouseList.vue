<template>
  <b-container v-if="selected == true && houses && houses.length != 0" class="bv-example-row mt-3">
    <b-list-group>
    <house-list-row v-for="(house, index) in overlaps" :key="index" :house="house" />
    </b-list-group>
  </b-container>
  <b-container v-else-if="selected == false && aptLists && aptLists.length != 0" class="bv-example-row mt-3">
    <b-list-group-item>
      <b-row class="m-2" style="color: black;">
        <b-col cols="10" class="align-self-center"><strong> {{ aptLists[0].아파트 }} </strong></b-col>
        <b-col cols="10" class="align-self-center"> 
          지번 : {{ aptLists[0].지번 }}
        </b-col>
        <b-col cols="10" class="align-self-center">
          층수 : {{ aptLists[0].층 }}층
        </b-col>
        <b-col cols="10" class="align-self-center" >
          건물노후 : {{ aptLists[0].건축년도 | built }}년
        </b-col>
        <b-col cols="10" class="align-self-center">
          전용면적 : {{ aptLists[0].전용면적 | acreage}}평
        </b-col>
      </b-row>
    <apt-list-row v-for="(apt, index) in aptLists" :key="index" :apt="apt" />
    </b-list-group-item>
  </b-container>
  <b-container v-else class="bv-example-row mt-3">
    <b-row>
      <b-col><b-alert show>주택 목록이 없습니다.</b-alert></b-col>
    </b-row>
  </b-container>
</template>

<script>
import HouseListRow from "@/components/House/HouseListRow.vue";
import AptListRow from "@/components/House/AptListRow.vue";
import { mapState, mapMutations, mapGetters } from "vuex";

export default {
  name: "HouseList",
  components: {
    HouseListRow,
    AptListRow
  },
  filters: {
    built(value) {
      if (!value) return value;
      return 2021 - parseInt(value);
    },
    acreage(value) {
      if (!value) return value;
      console.log(parseFloat(value))
      return (parseFloat(value) * 0.3025).toFixed(2);
    }
  },
  data() {
    return {

    };
  },
  
  created() {
    this.CLEAR_HOUSE_LIST();
  },
  computed: {
    ...mapState(["houses", "overlaps", "aptLists", "selected"]),
    ...mapGetters(["overlapHouse", "getAptList"])
  },
  watch: {
    overlapHouse(val) {
      console.log("overlap watch", val);
    },
    getAptList(val) {
      console.log("aptList watch", val);
    }
  },
  methods: {
    ...mapMutations(["CLEAR_HOUSE_LIST"]),
  }
};
</script>

<style>

</style>
