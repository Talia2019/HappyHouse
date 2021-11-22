<template>
  <b-container class="bv-example-row">
    <b-row class="my-4 d-flex justify-content-center">
      <b-col cols="10">
        <h3 class="mb-0">댓글 남기기</h3>
      </b-col>
      <b-col cols="2" class="d-flex justify-content-end">
        <b-button class="btn" variant="primary" @click.prevent="writeComment()"
          >등록</b-button
        ></b-col
      >
    </b-row>
    <b-row align-h="center">
      <b-col>
        <base-input
          size="lg"
          id="comment"
          type="text"
          placeholder=""
          v-model="commentText"
        >
        </base-input>
        <!-- <b-form-textarea
          id="comment"
          type="text"
          placeholder=""
          v-model="commentText"
          rows="1"
        >
        </b-form-textarea> -->
      </b-col>
    </b-row>
    <b-row
      align-h="center"
      class="mb-2"
      v-for="comment in comments"
      :key="comment.commentNo"
    >
      <b-col>
        <card class="comment-light">
          <b-row class="mb-2">
            <b-col class="h5" max-width="20px" cols="2">
              {{ comment.userId }}
            </b-col>
            <b-col class="h5 font-weight-300" cols="2">
              {{ comment.regTime }}
            </b-col>
            <b-col class="d-flex justify-content-end" cols="8">
              <b-button
                class="btn"
                variant="outline-warning"
                @click="deleteComment(comment.commentNo)"
                v-if="isOwner(userid)"
              >
                삭제
              </b-button>
            </b-col>
          </b-row>
          <b-row>
            <b-col class="h5 font-weight-300"> {{ comment.content }}</b-col>
          </b-row>
        </card>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { deleteComment } from "@/api/board";
import { mapState } from "vuex";

const memberStore = "memberStore";

export default {
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
  data() {
    return {
      commentText: "",
    };
  },
  props: {
    commentValue: {
      type: String,
      default: "",
    },
    userid: {
      type: String,
    },
    comments: {
      type: Array,
    },
    boardno: {
      type: Number,
    },
  },
  created() {
    this.commentText = this.commentValue;
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
    writeComment() {
      let err = true;
      let msg = "";
      err &&
        !this.commentText &&
        ((msg = "댓글 내용을 입력해주세요"), (err = false));
      err && !this.userInfo && ((msg = "로그인이 필요합니다"), (err = false));

      if (!err) {
        // console.log("댓글입력안함");
        alert(msg);
      } else {
        this.$emit("write-comment", this.commentText);
        this.commentText = "";
      }
    },
    deleteComment(commentno) {
      if (confirm("삭제 하시겠습니까?")) {
        deleteComment(commentno, () => {
          this.$router.go({
            name: "boardView",
            params: { articleno: this.boardno },
          });
        });
      }
    },
  },
};
</script>

<style scoped>
.comment-light {
  background-color: #fff6e6;
}
.base-input {
  height: 100px;
}
</style>
