<template>
  <b-container v-if="houses && houses.length != 0" class="bv-example-row mt-3">
    <b-list-group>
    <house-list-row v-for="(house, index) in overlaps" :key="index" :house="house" />
    </b-list-group>
  </b-container>
  <b-container v-else class="bv-example-row mt-3">
    <b-row>
      <b-col><b-alert show>주택 목록이 없습니다.</b-alert></b-col>
    </b-row>
  </b-container>
</template>

<script>
import HouseListRow from "@/components/House/HouseListRow.vue";
import { mapState, mapMutations, mapGetters } from "vuex";

export default {
  name: "HouseList",
  components: {
    HouseListRow,
  },
  data() {
    return {

    };
  },
  created() {
    this.CLEAR_HOUSE_LIST();
  },
  computed: {
    ...mapState(["houses", "overlaps"]),
    ...mapGetters(["overlapHouse"])
  },
  watch: {
    overlapHouse(val) {
      console.log("overlap watch", val);
    }
  },
  methods: {
    ...mapMutations(["CLEAR_HOUSE_LIST"]),
  }
};
</script>

<style>

</style>
