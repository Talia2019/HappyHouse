<template>
  <div>
    <b-row v-if="cardList.length > 0">
      <b-col xl="4" md="6">
        <wish-card
          title="Top 1"
          type="gradient-red"
          v-if="cardList.length > 0"
          :sub-title="cardList[0].houseName"
          icon="ni ni-favourite-28"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap"
              >{{ cardList[0].jibun }} {{ cardList[0].dongName }}</span
            >
            <br />
            <span class="text-nowrap">{{ cardList[0].dealAmount }} 원</span>
            <br />
            <span class="text-success mr-2"
              >관심 등록 수 {{ cardList[0].starCount }}</span
            >
          </template>
        </wish-card>
      </b-col>
      <b-col xl="4" md="6">
        <wish-card
          title="Top 2"
          type="gradient-red"
          v-if="cardList.length > 0"
          :sub-title="cardList[1].houseName"
          icon="ni ni-favourite-28"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap"
              >{{ cardList[1].jibun }} {{ cardList[1].dongName }}</span
            >
            <br />
            <span class="text-nowrap">{{ cardList[1].dealAmount }} 원</span>
            <br />
            <span class="text-success mr-2"
              >관심 등록 수 {{ cardList[1].starCount }}</span
            >
          </template>
        </wish-card>
      </b-col>
      <b-col xl="4" md="6">
        <wish-card
          title="Top 3"
          type="gradient-red"
          v-if="cardList.length > 0"
          :sub-title="cardList[2].houseName"
          icon="ni ni-favourite-28"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap"
              >{{ cardList[2].jibun }} {{ cardList[2].dongName }}</span
            >
            <br />
            <span class="text-nowrap">{{ cardList[2].dealAmount }} 원</span>
            <br />
            <span class="text-success mr-2"
              >관심 등록 수 {{ cardList[2].starCount }}</span
            >
          </template>
        </wish-card>
      </b-col>
    </b-row>
    <b-row v-else>
      <b-col xl="4" md="6">
        <wish-card
          title=" "
          type="gradient-red"
          sub-title="관심 등록된 아파트가 없습니다."
          icon="ni ni-favourite-28"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap">
              <!-- {{ cardList[0].jibun }} {{ cardList[0].dongName }} -->
            </span>
            <!-- <span class="text-nowrap">{{ cardList[0].dealAmount }}</span> -->
            <br />
            <span class="text-success mr-2">
              <!-- 관심 등록 수 {{ cardList[0].starCount }} -->
            </span>
          </template>
        </wish-card>
      </b-col>
      <b-col xl="4" md="6">
        <wish-card
          title=" "
          type="gradient-red"
          sub-title="관심 등록된 아파트가 없습니다."
          icon="ni ni-favourite-28"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap">
              <!-- {{ cardList[0].jibun }} {{ cardList[0].dongName }} -->
            </span>
            <br />
            <!-- <span class="text-nowrap">{{ cardList[0].dealAmount }}</span> -->
            <span class="text-success mr-2">
              <!-- 관심 등록 수 {{ cardList[0].starCount }} -->
            </span>
          </template>
        </wish-card>
      </b-col>
      <b-col xl="4" md="6">
        <wish-card
          title=" "
          type="gradient-red"
          sub-title="관심 등록된 아파트가 없습니다."
          icon="ni ni-favourite-28"
          class="mb-4"
        >
          <template slot="footer">
            <span class="text-nowrap">
              <!-- {{ cardList[0].jibun }} {{ cardList[0].dongName }} -->
            </span>
            <br />
            <!-- <span class="text-nowrap">{{ cardList[0].dealAmount }}</span> -->
            <span class="text-success mr-2">
              <!-- 관심 등록 수 {{ cardList[0].starCount }} -->
            </span>
          </template>
        </wish-card>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import WishCard from "@/components/Cards/WishCard";
import { topWish } from "@/api/wishlist";

export default {
  // 아파트명, 위치, 거래금액
  name: "wishcard",
  components: {
    WishCard,
  },
  data() {
    return {
      cardList: [],
    };
  },
  created() {
    topWish((response) => {
      this.cardList = response.data;
      console.log(this.cardList);
    });
  },
};
</script>
<style scoped></style>
