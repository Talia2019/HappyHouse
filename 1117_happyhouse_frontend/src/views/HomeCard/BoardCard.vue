<template>
  <div>
    <b-row v-if="topHits.length > 0">
      <b-col xl="4" md="6">
        <board-card
          title="Top 1"
          type="gradient-red"
          v-if="topHits.length > 0"
          :sub-title="topHits[0].subject"
          :articleno="topHits[0].boardNo"
          icon="ni ni-like-2"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap">작성자 {{ topHits[0].userId }}</span>
            <br />
            <span class="text-success mr-2">조회수 {{ topHits[0].hit }}</span>
          </template>
        </board-card>
      </b-col>
      <b-col xl="4" md="6">
        <board-card
          title="Top 2"
          type="gradient-orange"
          v-if="topHits.length > 1"
          :sub-title="topHits[1].subject"
          :articleno="topHits[1].boardNo"
          icon="ni ni-like-2"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap">작성자 {{ topHits[1].userId }}</span>
            <br />
            <span class="text-success mr-2">조회수 {{ topHits[1].hit }}</span>
          </template>
        </board-card>
      </b-col>
      <b-col xl="4" md="6">
        <board-card
          title="Top 3"
          type="gradient-green"
          v-if="topHits.length > 2"
          :sub-title="topHits[2].subject"
          :articleno="topHits[2].boardNo"
          icon="ni ni-like-2"
          class="mb-4"
        >
          <template slot="footer">
            <!-- <span class="text-danger mr-2">5.72%</span> -->
            <span class="text-nowrap">작성자 {{ topHits[2].userId }}</span>
            <br />
            <span class="text-success mr-2">조회수 {{ topHits[2].hit }}</span>
          </template>
        </board-card>
      </b-col>
    </b-row>
    <b-row v-else>
      <b-col xl="4" md="6">
        <board-card
          title=" "
          type="gradient-red"
          v-if="topHits.length < 1"
          sub-title="게시물이 없습니다."
          icon="ni ni-like-2"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap"> </span>
            <br />
            <span class="text-success mr-2"> </span>
          </template>
        </board-card>
      </b-col>
      <b-col xl="4" md="6">
        <board-card
          title=" "
          type="gradient-red"
          v-if="topHits.length < 2"
          sub-title="게시물이 없습니다."
          icon="ni ni-like-2"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap"> </span>
            <br />
            <span class="text-success mr-2"> </span>
          </template>
        </board-card>
      </b-col>
      <b-col xl="4" md="6">
        <board-card
          title=" "
          type="gradient-red"
          v-if="topHits.length < 3"
          sub-title="게시물이 없습니다."
          icon="ni ni-like-2"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap"> </span>
            <br />
            <span class="text-success mr-2"> </span>
          </template>
        </board-card>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import BoardCard from "@/components/Cards/BoardCard";
import { topArticle } from "@/api/board";

export default {
  name: "boardcard",
  components: {
    BoardCard,
  },
  data() {
    return {
      topHits: [],
    };
  },
  created() {
    topArticle((response) => {
      this.topHits = response.data;
      // console.log(this.topHits);
    });
  },
};
</script>
<style scoped></style>
