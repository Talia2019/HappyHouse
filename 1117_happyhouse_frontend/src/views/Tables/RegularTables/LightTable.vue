<template>
  <b-card no-body>
    <b-card-header class="border-0 table-light">
      <h3 class="mb-0">자유 게시판</h3>
    </b-card-header>

    <el-table
      class="table-responsive table table-light"
      header-row-class-name="thead-light"
      hover
      :data="articles"
    >
      <el-table-column label="제목" prop="subject" min-width="400px">
      </el-table-column>

      <el-table-column label="작성자" min-width="100px" prop="userId">
        <!-- <template v-slot="{ row }">
          <badge class="badge-dot mr-4" type="">
            <i :class="`bg-${row.statusType}`"></i>
            <span class="status" :class="`text-${row.statusType}`">{{
              row.status
            }}</span>
          </badge>
        </template> -->
      </el-table-column>

      <el-table-column label="조회수" min-width="50px" prop="hit">
        <!-- <template v-slot="{ row }">
          <b-media no-body class="align-items-center">
            <b-media-body>
              <span class="font-weight-600 name mb-0 text-sm">{{
                row.title
              }}</span>
            </b-media-body>
          </b-media>
        </template> -->
      </el-table-column>

      <el-table-column label="작성일" prop="regTime" min-width="100px">
        <!-- <template v-slot="{ row }">
          <div class="d-flex align-items-center">
            <span class="completion mr-2">{{ row.completion }}%</span>
            <div>
              <base-progress :type="row.statusType" :value="row.completion" />
            </div>
          </div>
        </template> -->
      </el-table-column>
    </el-table>

    <!-- <el-table-column label="Users" min-width="190px">
        <div class="avatar-group">
          <a
            href="#"
            class="avatar avatar-sm rounded-circle"
            data-toggle="tooltip"
            data-original-title="Ryan Tompson"
          >
            <img alt="Image placeholder" src="img/theme/team-1.jpg" />
          </a>
          <a
            href="#"
            class="avatar avatar-sm rounded-circle"
            data-toggle="tooltip"
            data-original-title="Romina Hadid"
          >
            <img alt="Image placeholder" src="img/theme/team-2.jpg" />
          </a>
          <a
            href="#"
            class="avatar avatar-sm rounded-circle"
            data-toggle="tooltip"
            data-original-title="Alexander Smith"
          >
            <img alt="Image placeholder" src="img/theme/team-3.jpg" />
          </a>
          <a
            href="#"
            class="avatar avatar-sm rounded-circle"
            data-toggle="tooltip"
            data-original-title="Jessica Doe"
          >
            <img alt="Image placeholder" src="img/theme/team-4.jpg" />
          </a>
        </div>
      </el-table-column> -->

    <b-card-footer class="py-4 d-flex justify-content-end table-light">
      <base-pagination
        v-model="currentPage"
        :per-page="10"
        :total="50"
      ></base-pagination>
    </b-card-footer>
  </b-card>
</template>
<script>
import http from "@/util/http-common";
import projects from "./../projects";
import { Table, TableColumn } from "element-ui";
export default {
  name: "light-table",
  components: {
    [Table.name]: Table,
    [TableColumn.name]: TableColumn,
  },
  data() {
    return {
      projects,
      currentPage: 1,
      articles: [],
      //   fields: [
      //     { key: "boardNo", label: "글번호", tdClass: "tdClass" },
      //     { key: "subject", label: "제목", tdClass: "tdSubject" },
      //     { key: "userId", label: "작성자", tdClass: "tdClass" },
      //     { key: "regTime", label: "작성일", tdClass: "tdClass" },
      //     { key: "hit", label: "조회수", tdClass: "tdClass" },
      //   ],
    };
  },
  created() {
    http.get(`/board`).then(({ data }) => {
      this.articles = data;
      this.articles.forEach(function (article) {
        article.regTime = article.regTime.substring(0, 10);
      });
    });
    console.log(this.articles);
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "BoardWrite" });
    },
  },
};
</script>
<style>
.table-light,
.table-responsive,
.el-table.table {
  background-color: #fff6e6;
  color: #3f464d;
}

.el-table th,
.el-table tr {
  background-color: #fff6e6;
}

.el-table td,
.el-table th.is-leaf {
  border-bottom: none;
}
</style>
