<template>
  <div container-fluid>
    <card>
      <b-card-header class="text-center border-0">
        <div class="d-flex justify-content-center">
          <div>
            <h2 class="mb-0">자유 게시판</h2>
          </div>
        </div>
      </b-card-header>
      <hr class="my-4" />
      <b-card-body class="pt-0">
        <b-row style="margin-bottom: 30px">
          <b-col>
            <div class="d-flex justify-content-center">
              <div>
                <h3 class="mb-0">{{ article.subject }}</h3>
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
          <div class="row-vh">
            <div class="h-50 content">
              {{ article.content }}
            </div>
          </div>
        </b-row>
        <b-row>
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
import { getArticle, deleteArticle } from "@/api/board";

export default {
  name: "boardView",
  components: {
    // contentArea: {
    //   template: this.article.content,
    // },
  },
  data() {
    return {
      article: {},
    };
  },
  computed: {
    message() {
      if (this.article.content)
        return this.article.content.split("\r\n").join("<br>");
      return "";
    },
  },
  created() {
    getArticle(
      this.$route.params.articleno,
      (response) => {
        this.article = response.data;
        // this.article.content = this.article.content.replace(
        //   /(?:\r\n|\r|\n)/g,
        //   "<br/>"
        // );
        // console.log(this.article);
      },
      (error) => {
        console.log("게시글 얻어오기 에러", error);
      }
    );
  },
  methods: {
    listArticle() {
      this.$router.push({ name: "boardList" });
    },
    moveModifyArticle() {
      this.$router.replace({
        name: "boardUpdate",
        params: { articleno: this.article.boardNo },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    removeArticle() {
      if (confirm("삭제 하시겠습니까?")) {
        deleteArticle(this.article.boardNo, () => {
          this.$router.push({ name: "boardList" });
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
  height: 300px;
}
.content {
  white-space: pre-line;
}
</style>
