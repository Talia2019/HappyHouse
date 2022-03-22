<template>
  <card class="bv-example-row mt-3">
    <notice-write-form type="modify" />
  </card>
</template>

<script>
import NoticeWriteForm from "./child/NoticeWriteForm.vue";

export default {
  name: "noticeUpdate",
  components: {
    NoticeWriteForm,
  },
};
</script>

<style>
.light {
  background-color: #fff6e6;
}
</style>
