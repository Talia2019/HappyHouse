<template>
  <div container-fluid>
    <card>
      <b-card-header class="text-center border-0">
        <div class="d-flex justify-content-center">
          <div>
            <h1 class="mb-0">자유 게시판</h1>
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
        <b-row class="my-4" v-if="isOwner(article.userId)">
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

        <hr class="my-4" />
        <b-row>
          <comment
            v-on:write-comment="registerComment"
            :comments="comments"
            :boardno="article.boardNo"
            :userid="article.userId"
          ></comment>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
import {
  getArticle,
  deleteArticle,
  deleteAllComment,
  writeComment,
  listComment,
} from "@/api/board";
import Comment from "@/components/Comment";
import { mapState } from "vuex";

import Swal from "sweetalert2/dist/sweetalert2.js";
import "sweetalert2/src/sweetalert2.scss";

const memberStore = "memberStore";

export default {
  name: "boardView",
  components: {
    Comment,
    // contentArea: {
    //   template: this.article.content,
    // },
  },
  data() {
    return {
      article: {},
      comments: [],
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
  // actions: {
  //   commentAllDelete({ commit }, user) {
  //     deleteComment(
  //       user,
  //       (response) => {
  //         if (response.data === "success") {
  //           commit("SET_USER_INFO", user);
  //         } else {
  //           console.log("");
  //         }
  //       },
  //       (error) => {
  //         console.log(error);
  //       }
  //     );
  //   },
  // },
  created() {
    getArticle(
      this.$route.params.articleno,
      (response) => {
        this.article = response.data;
        listComment(
          this.article.boardNo,
          (response) => {
            this.comments = response.data;
            // console.log(this.comments);
          },
          (error) => {
            console.log(error);
          }
        );
      },
      (error) => {
        console.log("게시글 얻어오기 에러", error);
      }
    );
  },
  methods: {
    isOwner(id) {
      // console.log(this.isLogin);
      if (this.userInfo) {
        if (this.userInfo.userid == id || this.userInfo.userid == "admin")
          return true;
      }
      return false;
    },
    listArticle() {
      this.$router.push({ name: "boardList" });
    },
    refreshArticle() {
      this.$router
        .go({
          name: "boardView",
          params: { articleno: this.article.boardNo },
        })
        .catch((err) => {
          console.log(err);
        });
      // :to="{
      //   name: 'boardView',
      //   params: { articleno: row.boardNo },
      // }"
    },
    moveModifyArticle() {
      this.$router.replace({
        name: "boardUpdate",
        params: { articleno: this.article.boardNo },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    // deleteAllComment(boardno) {
    //   if (confirm("삭제 하시겠습니까?")) {
    //     deleteAllComment(boardno, () => {
    //       this.$router.go({
    //         name: "boardView",
    //         params: { articleno: this.boardno },
    //       });
    //     });
    //   }
    // },
    removeArticle() {
      const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
          confirmButton: "btn btn-success",
          cancelButton: "btn btn-danger",
        },
        buttonsStyling: false,
      });

      swalWithBootstrapButtons
        .fire({
          title: "정말로 삭제하시겠습니까?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonText: "삭제하기",
          cancelButtonText: "취소",
          reverseButtons: true,
        })
        .then((result) => {
          if (result.isConfirmed) {
            swalWithBootstrapButtons.fire("삭제되었습니다!", "", "success");
            // deleteAllComment(this.comment.boardNo, () => {
            //   this.$router.push({ name: "boardList" });
            // });
            deleteAllComment(this.article.boardNo);
            deleteArticle(this.article.boardNo, () => {
              this.$router.push({ name: "boardList" });
            });
          } else if (
            /* Read more about handling dismissals below */
            result.dismiss === Swal.DismissReason.cancel
          ) {
            swalWithBootstrapButtons.fire("취소되었습니다!", "", "error");
          }
        });
    },
    registerComment(value) {
      // console.log(this.article.articleno);
      writeComment(
        // boardno, userid, content
        {
          boardNo: this.article.boardNo,
          //수정필요!!!!!!!!!!!!!!!!! article.userId 아니고 현재 로그인한사람으로 돼야함!!!!!!
          userId: this.userInfo.userid,
          content: value,
        },
        ({ data }) => {
          // let msg = "등록 처리시 문제가 발생했습니다.";
          if (data === "success") {
            // msg = "등록이 완료되었습니다.";
          }
          // alert(msg);
          this.refreshArticle();
        },
        (error) => {
          console.log(error);
        }
      );
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
