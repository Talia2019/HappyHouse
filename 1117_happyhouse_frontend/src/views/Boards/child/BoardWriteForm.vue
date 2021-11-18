<template>
  <card>
    <b-form @submit="onSubmit" @reset="onReset">
      <b-row align-v="center" slot="header">
        <b-col cols="8">
          <h3 class="mb-0">글 작성</h3>
        </b-col>
        <b-col cols="4" class="text-right">
          <!-- <a href="#!" class="btn btn-sm btn-primary">Settings</a> -->
          <b-button
            type="submit"
            variant="primary"
            class="m-1"
            v-if="this.type === 'register'"
            >완료</b-button
          >
          <b-button type="submit" variant="primary" class="m-1" v-else
            >완료</b-button
          >
        </b-col>
      </b-row>
      <div class="pl-lg-4">
        <b-row>
          <b-col lg="6">
            <base-input
              id="userid"
              type="text"
              label="작성자"
              :disabled="isUserid"
              placeholder=""
              required
              v-model="article.userId"
            >
            </base-input>
          </b-col>
          <b-col lg="6">
            <base-input
              id="subject"
              type="text"
              label="제목"
              placeholder=""
              required
              v-model="article.subject"
            >
            </base-input>
          </b-col>
          <b-col>
            <b-form-group
              label="내용"
              label-class="form-control-label"
              class="mb-0"
              label-for="content"
            >
              <b-form-textarea
                rows="6"
                value=""
                id="content"
                placeholder=""
                required
                v-model="article.content"
              ></b-form-textarea>
            </b-form-group>
          </b-col>
        </b-row>
        <!-- <b-row class="buttonstyle">
          <b-button
            type="submit"
            variant="primary"
            class="m-1"
            v-if="this.type === 'register'"
            >글작성</b-button
          >
          <b-button type="submit" variant="primary" class="m-1" v-else
            >글수정</b-button
          >
          <b-button type="reset" variant="danger" class="m-1"
            >초기화</b-button
          >
          </b-row> -->
      </div>
    </b-form>
  </card>
</template>

<script>
import { writeArticle, getArticle, modifyArticle } from "@/api/board";

export default {
  name: "BoardWriteForm",
  data() {
    return {
      article: {
        boardNo: 0,
        userId: "",
        subject: "",
        content: "",
      },
      isUserid: false,
    };
  },
  props: {
    type: { type: String },
  },
  created() {
    if (this.type === "modify") {
      getArticle(
        this.$route.params.articleno,
        ({ data }) => {
          this.article = data;
        },
        (error) => {
          console.log(error);
        }
      );
      this.isUserid = true;
    }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();

      let err = true;
      let msg = "";
      !this.article.userId &&
        ((msg = "작성자를 입력해주세요"),
        (err = false),
        this.$refs.userid.focus());
      err &&
        !this.article.subject &&
        ((msg = "제목을 입력해주세요"),
        (err = false),
        this.$refs.subject.focus());
      err &&
        !this.article.content &&
        ((msg = "내용을 입력해주세요"),
        (err = false),
        this.$refs.content.focus());

      if (!err) alert(msg);
      else
        this.type === "register" ? this.registArticle() : this.updateArticle();
    },
    onReset(event) {
      event.preventDefault();
      this.article.boardNo = 0;
      this.article.userId = "";
      this.article.subject = "";
      this.article.content = "";
      this.$router.push({ name: "boardWrite" });
    },
    registArticle() {
      writeArticle(
        {
          userId: this.article.userId,
          subject: this.article.subject,
          content: this.article.content,
        },
        ({ data }) => {
          // let msg = "등록 처리시 문제가 발생했습니다.";
          if (data === "success") {
            // msg = "등록이 완료되었습니다.";
          }
          // alert(msg);
          this.moveList();
        },
        (error) => {
          console.log(error);
        }
      );
    },
    updateArticle() {
      modifyArticle(
        {
          boardNo: this.article.boardNo,
          userId: this.article.userId,
          subject: this.article.subject,
          content: this.article.content,
        },
        ({ data }) => {
          let msg = "수정 처리시 문제가 발생했습니다.";
          if (data === "success") {
            msg = "수정이 완료되었습니다.";
          }
          alert(msg);
          // 현재 route를 /list로 변경.
          this.$router.push({ name: "boardList" });
        },
        (error) => {
          console.log(error);
        }
      );
    },
    moveList() {
      this.$router.push({ name: "boardList" });
    },
  },
};
</script>

<style>
.light {
  background-color: "#fff6e6";
}
.buttonstyle {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}
</style>
