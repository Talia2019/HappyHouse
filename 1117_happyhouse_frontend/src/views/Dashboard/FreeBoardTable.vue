<template>
  <b-card body-class="p-0" header-class="border-0">
    <template v-slot:header>
      <b-row align-v="center">
        <b-col>
          <h3 class="mb-0">자유 게시판</h3>
        </b-col>
        <b-col class="text-right">
          <b-button class="btn-sm" @click="moveFreeBoard()" variant="primary"
            >전체 보기</b-button
          >
        </b-col>
      </b-row>
    </template>

    <el-table
      v-if="articles.length > 0"
      class="table-responsive table hover-table"
      :data="articles"
      header-row-class-name="thead-light"
    >
      <el-table-column label="제목" min-width="130px" prop="page">
        <template v-slot="{ row }">
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
      <el-table-column label="작성자" min-width="70px" prop="userId">
      </el-table-column>
      <el-table-column label="조회수" min-width="70px" prop="hit">
      </el-table-column>

      <el-table-column label="작성일" min-width="70px" prop="regTime">
        <template v-slot="{ row }">
          {{ row.regTime }}
        </template>
      </el-table-column>
    </el-table>
    <div v-if="articles.length == 0" class="my-4 d-flex justify-content-center">
      <h3 class="mb-0">게시물이 없습니다!</h3>
    </div>
  </b-card>
</template>
<script>
import {
  Table,
  TableColumn,
  DropdownMenu,
  DropdownItem,
  Dropdown,
} from "element-ui";
import { listArticle } from "@/api/board";

export default {
  name: "page-visits-table",
  components: {
    [Table.name]: Table,
    [TableColumn.name]: TableColumn,
    [Dropdown.name]: Dropdown,
    [DropdownItem.name]: DropdownItem,
    [DropdownMenu.name]: DropdownMenu,
  },
  data() {
    return {
      articles: [],
    };
  },
  methods: {
    moveFreeBoard() {
      this.$router.push({ name: "boards" });
    },
  },
  created() {
    let param = {
      pg: 1,
      spp: 5,
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
  },
};
</script>
<style></style>
