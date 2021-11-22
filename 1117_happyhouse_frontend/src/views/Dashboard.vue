<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-5 bg-gradient-success">
      <!-- Card stats -->
      <b-row v-if="topHits.length == 3" class="top-title pl-4 pb-4">
        <b> 실시간 인기글</b></b-row
      >
      <b-row v-if="topHits.length == 3">
        <b-col xl="4" md="6">
          <board-card
            title="Top 1"
            type="gradient-red"
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
    </base-header>

    <!--Charts-->
    <b-container fluid class="mt--7">
      <!-- <b-row>
        <b-col xl="8" class="mb-5 mb-xl-0">
          <card type="default" header-classes="bg-transparent">
            <b-row align-v="center" slot="header">
              <b-col>
                <h6 class="text-light text-uppercase ls-1 mb-1">Overview</h6>
                <h5 class="h3 text-white mb-0">Sales value</h5>
              </b-col>
              <b-col>
                <b-nav class="nav-pills justify-content-end">
                  <b-nav-item
                       class="mr-2 mr-md-0"
                       :active="bigLineChart.activeIndex === 0"
                       link-classes="py-2 px-3"
                       @click.prevent="initBigChart(0)">
                      <span class="d-none d-md-block">Month</span>
                      <span class="d-md-none">M</span>
                  </b-nav-item>
                  <b-nav-item
                    link-classes="py-2 px-3"
                    :active="bigLineChart.activeIndex === 1"
                    @click.prevent="initBigChart(1)"
                  >
                    <span class="d-none d-md-block">Week</span>
                    <span class="d-md-none">W</span>
                  </b-nav-item>
                </b-nav>
              </b-col>
            </b-row>
            <line-chart
              :height="350"
              ref="bigChart"
              :chart-data="bigLineChart.chartData"
              :extra-options="bigLineChart.extraOptions"
            >
            </line-chart>
          </card>
        </b-col>

        <b-col xl="4" class="mb-5 mb-xl-0">
          <card header-classes="bg-transparent">
            <b-row align-v="center" slot="header">
              <b-col>
                <h6 class="text-uppercase text-muted ls-1 mb-1">Performance</h6>
                <h5 class="h3 mb-0">Total orders</h5>
              </b-col>
            </b-row>

            <bar-chart
              :height="350"
              ref="barChart"
              :chart-data="redBarChart.chartData"
            >
            </bar-chart>
          </card>
        </b-col>
      </b-row> -->
      <!-- End charts-->

      <!--Tables-->
      <b-row class="mt-5">
        <b-col xl="6" class="mb-5 mb-xl-0">
          <free-board-table></free-board-table>
        </b-col>
        <b-col xl="6" class="mb-5 mb-xl-0">
          <notice-board-table></notice-board-table>
        </b-col>
      </b-row>
      <!--End tables-->
    </b-container>
  </div>
</template>
<script>
// Charts
import * as chartConfigs from "@/components/Charts/config";
import LineChart from "@/components/Charts/LineChart";
import BarChart from "@/components/Charts/BarChart";

// Components
import BaseProgress from "@/components/BaseProgress";
import BoardCard from "@/components/Cards/BoardCard";

// Tables
// import SocialTrafficTable from './Dashboard/SocialTrafficTable';
// import PageVisitsTable from './Dashboard/PageVisitsTable';
import FreeBoardTable from "./Dashboard/FreeBoardTable";
import NoticeBoardTable from "./Dashboard/NoticeBoardTable";

import { topArticle } from "@/api/board";

export default {
  components: {
    LineChart,
    BarChart,
    BaseProgress,
    BoardCard,
    FreeBoardTable,
    NoticeBoardTable,
  },
  data() {
    return {
      topHits: [],
      bigLineChart: {
        allData: [
          [0, 20, 10, 30, 15, 40, 20, 60, 60],
          [0, 20, 5, 25, 10, 30, 15, 40, 40],
        ],
        activeIndex: 0,
        chartData: {
          datasets: [
            {
              label: "Performance",
              data: [0, 20, 10, 30, 15, 40, 20, 60, 60],
            },
          ],
          labels: ["May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        },
        extraOptions: chartConfigs.blueChartOptions,
      },
      redBarChart: {
        chartData: {
          labels: ["Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
          datasets: [
            {
              label: "Sales",
              data: [25, 20, 30, 22, 17, 29],
            },
          ],
        },
        extraOptions: chartConfigs.blueChartOptions,
      },
    };
  },
  methods: {
    initBigChart(index) {
      let chartData = {
        datasets: [
          {
            label: "Performance",
            data: this.bigLineChart.allData[index],
          },
        ],
        labels: ["May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
      };
      this.bigLineChart.chartData = chartData;
      this.bigLineChart.activeIndex = index;
    },
  },
  mounted() {
    this.initBigChart(0);
  },
  created() {
    topArticle((response) => {
      this.topHits = response.data;
      console.log(this.topHits);
    });
  },
};
</script>
<style>
.el-table .cell {
  padding-left: 0px;
  padding-right: 0px;
}
.bg-success {
  background: #2186c4 !important;
}
.top-title {
  color: cornsilk;
  font-size: 20px;
}
</style>
