<template>
  <b-container class="bv-example-row">
    <b-row class="ml-2 my-4 d-flex justify-content-left">
      <h3 class="mb-0">댓글 남기기</h3>
    </b-row>
    <b-row align-h="center" class="ml-2">
      <b-col cols="10">
        <b-form-textarea
          id="comment"
          type="text"
          placeholder=""
          v-model="commentText"
          rows="2"
        >
        </b-form-textarea>
      </b-col>
      <b-col cols="2">
        <b-button class="btn" variant="primary" @click="writeComment()"
          >등록</b-button
        >
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
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
  },
  created() {
    this.commentText = this.commentValue;
  },
  methods: {
    writeComment() {
      let err = true;
      let msg = "";
      err &&
        !this.commentText &&
        ((msg = "댓글 내용을 입력해주세요"), (err = false));

      if (!err) {
        console.log("댓글입력안함");
        alert(msg);
      }
      // console.log("부모호출.." + this.value + " " + this.pagevalue);
      else {
        this.$emit("write-comment", this.commentText);
        this.commentText = "";
      }
    },
  },
};
</script>

<style></style>
