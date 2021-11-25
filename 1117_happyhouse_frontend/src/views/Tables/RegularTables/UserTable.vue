<template>
  <b-card body-class="p-0" class="table-light">
    <template v-slot:header>
      <b-row align-v="center">
        <b-col>
          <h2 class="mb-0">회원 관리</h2>
        </b-col>
      </b-row>

      <b-row class="mt-4">
        <!-- <b-col cols="1" class="mr-2">
          <b-dropdown
            :text="dropdown[selecteddrop]"
            variant="outline-primary"
            style="width: 200px"
          >
            <b-dropdown-item @click="changeDropdown(0)">{{
              dropdown[0]
            }}</b-dropdown-item>
            <b-dropdown-item @click="changeDropdown(1)">{{
              dropdown[1]
            }}</b-dropdown-item>
          </b-dropdown>
        </b-col> -->
        <b-col class="ml-3 mr-3">
          <b-form
            class="navbar-search text-center"
            :class="
              $route.meta.searchClasses
                ? $route.meta.searchClasses
                : 'navbar-search-light'
            "
            id="navbar-search-main"
          >
            <b-form-group class="mb-0">
              <b-input-group class="input-group-alternative input-group-merge">
                <div class="input-group-prepend">
                  <span class="input-group-text"></span>
                </div>
                <b-form-input placeholder="Search" type="text"></b-form-input>
              </b-input-group>
            </b-form-group>
            <!-- <button
              type="button"
              class="close"
              data-action="search-close"
              data-target="#navbar-search-main"
              aria-label="Close"
            >
              <span aria-hidden="true">×</span>
            </button> -->
          </b-form>
        </b-col>
        <!-- <b-col> <base-input></base-input></b-col> -->
        <!-- <b-col>
          <b-button @click="moveWrite()" class="btn" variant="primary"
            >글쓰기</b-button
          >
        </b-col> -->
      </b-row>
    </template>

    <!-- <b-input-group class="mb-2">
      <b-input-group-prepend is-text>
        <input type="checkbox" aria-label="Checkbox for following text input" />
      </b-input-group-prepend>
      <b-form-input aria-label="Text input with checkbox"></b-form-input>
    </b-input-group> -->

    <el-table
      v-if="articles.length > 0"
      class="table hover-table"
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

    <div v-if="articles.length == 0" class="my-4 d-flex justify-content-center">
      <h3 class="mb-0">게시물이 없습니다!</h3>
    </div>
    <b-card-footer class="py-4 table-light">
      <div class="row d-flex justify-content-center">
        <base-pagination
          class="d-flex justify-content-end"
          v-model="currentPage"
          v-on:change-page="changePage"
          :per-page="10"
          :total="totalPages"
        ></base-pagination>
      </div>
    </b-card-footer>
  </b-card>
</template>
<script>
import { listArticle, searchArticle, totalArticle } from "@/api/board";
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
      totalPages: 10,
      articles: [],
      dropdown: ["제목  ", "작성자"],
      selecteddrop: 0,
      searchWord: "",
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
        // console.log(this.articles);
      },
      (error) => {
        console.log(error);
      }
    );
    totalArticle(param, (response) => {
      this.totalPages = response.data;
      // console.log("개수:" + this.totalPages);
    });
    // this.$on("changePage", (val) => {
    //   console.log("페이지:" + val);
    //   alert(val);
    // });
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "boardWrite" });
    },
    changeDropdown(index) {
      this.selecteddrop = index;
    },
    searchList() {
      this.currentPage = 0;
      let keyWord;
      if (this.selecteddrop == 0) keyWord = "subject";
      else keyWord = "userId";
      let param = {
        pg: 1,
        spp: 10,
        key: keyWord,
        word: this.searchWord,
      };
      searchArticle(
        param,
        (response) => {
          this.articles = response.data;
          // console.log(response.data);
        },
        (error) => {
          console.log(error);
        }
      );
      totalArticle(param, (response) => {
        this.totalPages = response.data;
        // console.log("개수:" + this.totalPages);
      });
    },
    testFunc() {
      console.log("test" + this.currentPage);
    },
    changePage(value) {
      // // console.log("불렸는가?" + this.currentPage + " " + value);
      // let param = {
      //   pg: value,
      //   spp: 10,
      //   key: null,
      //   word: null,
      // };
      // listArticle(
      //   param,
      //   (response) => {
      //     this.articles = response.data;
      //   },
      //   (error) => {
      //     console.log(error);
      //   }
      // );
      let keyWord;
      if (this.selecteddrop == 0) keyWord = "subject";
      else keyWord = "userId";
      let param = {
        pg: value,
        spp: 10,
        key: keyWord,
        word: this.searchWord,
      };
      searchArticle(
        param,
        (response) => {
          this.articles = response.data;
          // console.log(response.data);
        },
        (error) => {
          console.log(error);
        }
      );
      totalArticle(param, (response) => {
        this.totalPages = response.data;
        // console.log("개수:" + this.totalPages);
      });
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
.hover-table:hover tbody tr:hover td {
  background: #fff6e6;
  color: black;
}
.router-link {
  color: black;
}
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
