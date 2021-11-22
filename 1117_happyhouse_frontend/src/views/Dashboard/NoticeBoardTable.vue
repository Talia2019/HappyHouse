<template>
  <b-card body-class="p-0" header-class="border-0">
    <template v-slot:header>
      <b-row align-v="center">
        <b-col>
          <h3 class="mb-0">공지사항</h3>
        </b-col>
        <b-col class="text-right">
          <b-button class="btn-sm" @click="moveNoticeBoard()" variant="primary"
            >전체 보기</b-button
          >
        </b-col>
      </b-row>
    </template>

    <el-table
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
                  name: 'noticeView',
                  params: { articleno: row.noticeNo },
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
import { listNotice } from "@/api/notice";

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
    moveNoticeBoard() {
      this.$router.push({ name: "notices" });
    },
  },
  created() {
    let param = {
      pg: 1,
      spp: 5,
      key: null,
      word: null,
    };
    listNotice(
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
