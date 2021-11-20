<template>
  <div container-fluid>
    <card>
      <b-card-header class="text-center border-0">
        <div class="d-flex justify-content-center">
          <div>
            <h1 class="mb-0">공지사항</h1>
          </div>
        </div>
      </b-card-header>
      <hr class="my-4" />
      <b-card-body class="pt-0">
        <b-row style="margin-bottom: 30px">
          <b-col>
            <div class="d-flex justify-content-center">
              <div>
                <h2 class="mb-0">{{ article.subject }}</h2>
              </div>
            </div>
          </b-col>
        </b-row>
        <b-row>
          <b-col class="h5" min-width="20px">작성자 </b-col>
          <b-col class="h5 font-weight-300" style="width: 35%"
            >{{ article.userId }}
          </b-col>
          <b-col class="h5" min-width="20px">작성일 </b-col>
          <b-col class="h5 font-weight-300" style="width: 35%"
            >{{ article.regTime }}
          </b-col>
          <b-col class="h5" min-width="20px">조회수 </b-col>
          <b-col class="h5 font-weight-300" style="width: 35%"
            >{{ article.hit }}
          </b-col>
        </b-row>
        <hr class="my-4" />
        <b-row>
          <div class="ml-4 my-4 row-vh">
            <div class="content">
              {{ article.content }}
            </div>
          </div>
        </b-row>
        <b-row class="my-4" v-if="userInfo.userid == 'admin'">
          <b-col class="text-right">
            <b-button
              variant="outline-info"
              @click="moveModifyArticle"
              class="m-1"
              >수정</b-button
            >
            <b-button
              variant="outline-danger"
              class="m-1"
              @click="removeArticle"
              >삭제</b-button
            >
          </b-col>
        </b-row>
      </b-card-body>
    </card>
    <div class="buttonclass d-flex justify-content-center">
      <b-button @click="listArticle()" class="m-1" variant="primary"
        >목록</b-button
      >
    </div>
  </div>
</template>
<script>
import { getNotice, deleteNotice } from "@/api/notice";
import { mapState } from "vuex";

const memberStore = "memberStore";

export default {
  name: "noticeView",
  data() {
    return {
      article: {},
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    message() {
      if (this.article.content)
        return this.article.content.split("\r\n").join("<br>");
      return "";
    },
  },
  created() {
    getNotice(
      this.$route.params.articleno,
      (response) => {
        this.article = response.data;
      },
      (error) => {
        console.log("공지사항 얻어오기 에러", error);
      }
    );
  },
  methods: {
    listArticle() {
      this.$router.push({ name: "noticeList" });
    },
    refreshArticle() {
      this.$router.go({
        name: "noticeView",
        params: { articleno: this.article.noticeNo },
      });
      // :to="{
      //   name: 'boardView',
      //   params: { articleno: row.boardNo },
      // }"
    },
    moveModifyArticle() {
      this.$router.replace({
        name: "noticeUpdate",
        params: { articleno: this.article.noticeNo },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    removeArticle() {
      if (confirm("삭제 하시겠습니까?")) {
        deleteNotice(this.article.noticeNo, () => {
          this.$router.push({ name: "noticeList" });
        });
      }
    },
  },
};
</script>
<style scoped>
.bg-gradient-success {
  background: #2186c4 !important;
}
.buttonclass {
  margin-top: 20px;
}
.row-vh {
  height: auto;
}
.content {
  white-space: pre-line;
  overflow: hidden;
  height: auto;
}
</style>
