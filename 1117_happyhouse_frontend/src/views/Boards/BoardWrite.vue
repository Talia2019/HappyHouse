<template>
  <card class="bv-example-row mt-3">
    <board-write-form type="register" />
  </card>
</template>

<script>
import BoardWriteForm from "./child/BoardWriteForm.vue";

export default {
  name: "boardWrite",
  components: {
    BoardWriteForm,
  },
};
</script>

<style>
.light {
  background-color: #fff6e6;
}
</style>
