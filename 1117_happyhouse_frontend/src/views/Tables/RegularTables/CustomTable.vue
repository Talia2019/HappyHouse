<template>
  <b-card body-class="p-0">
    <template v-slot:header>
      <b-row align-v="center">
        <b-col>
          <h3 class="mb-0">자유 게시판</h3>
        </b-col>
        <b-col class="text-right">
          <b-button @click="moveWrite()" class="btn" variant="primary"
            >글쓰기</b-button
          >
        </b-col>
      </b-row>
    </template>

    <el-table
      class="table"
      header-row-class-name="thead-light"
      hover
      :data="articles"
    >
      <el-table-column label="제목" prop="subject" min-width="370px"
        ><template v-slot="{ row }">
          <div class="d-flex align-items-center">
            <span class="font-weight-600 name mb-0 text-sm">
              <router-link
                :to="{
                  name: 'boardView',
                  params: { articleno: row.boardNo },
                }"
                >{{ row.subject }}</router-link
              >
            </span>
          </div>
        </template>
      </el-table-column>

      <el-table-column label="작성자" min-width="100px" prop="userId">
      </el-table-column>

      <el-table-column label="조회수" min-width="50px" prop="hit">
        <template v-slot="{ row }">
          <b-media no-body class="align-items-center">
            <b-media-body>
              <span class="name mb-0 text-sm">{{ row.hit }}</span>
            </b-media-body>
          </b-media>
        </template>
      </el-table-column>

      <el-table-column label="작성일" prop="regTime" min-width="100px">
        <template v-slot="{ row }">
          <div class="d-flex align-items-center">
            <span class="completion mr-2">{{ row.regTime }}</span>
          </div>
        </template>
      </el-table-column>
    </el-table>

    <b-card-footer class="py-4 table-light">
      <b-row>
        <div class="pb-5">
          <b-input-group>
            <template #prepend>
              <b-dropdown
                :text="dropdown[selecteddrop]"
                variant="outline-primary"
              >
                <b-dropdown-item @click="changeDropdown(0)">{{
                  dropdown[0]
                }}</b-dropdown-item>
                <b-dropdown-item @click="changeDropdown(1)">{{
                  dropdown[1]
                }}</b-dropdown-item>
              </b-dropdown>
            </template>
            <b-form-input></b-form-input>

            <b-input-group-append>
              <b-button variant="primary">검색</b-button>
            </b-input-group-append>
          </b-input-group>
        </div>
      </b-row>
      <div class="row d-flex justify-content-center">
        <base-pagination
          class="d-flex justify-content-end"
          v-model="currentPage"
          :per-page="10"
          :total="50"
        ></base-pagination>
      </div>
    </b-card-footer>
  </b-card>
</template>
<script>
import { listArticle } from "@/api/board";
import { Table, TableColumn } from "element-ui";

export default {
  name: "custom-table",
  components: {
    [Table.name]: Table,
    [TableColumn.name]: TableColumn,
  },
  data() {
    return {
      currentPage: 1,
      articles: [],
      dropdown: ["제목", "작성자"],
      selecteddrop: 0,
    };
  },
  created() {
    let param = {
      pg: 1,
      spp: 10,
      key: null,
      word: null,
    };
    listArticle(
      param,
      (response) => {
        this.articles = response.data;
      },
      (error) => {
        console.log(error);
      }
    );
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "boardWrite" });
    },
    changeDropdown(index) {
      this.selecteddrop = index;
    },
    // viewArticle(article) {
    //   this.$router.go({
    //     name: "boardView",
    //     params: { articleno: article.boardNo },
    //   });
    // },
  },
};
</script>
<style>
/* .table-light,
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
} */
</style>
