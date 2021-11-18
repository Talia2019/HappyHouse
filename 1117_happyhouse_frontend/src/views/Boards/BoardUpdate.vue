<template>
  <card class="bv-example-row mt-3">
    <board-write-form type="modify" />
  </card>
</template>

<script>
import BoardWriteForm from "./child/BoardWriteForm.vue";

export default {
  name: "boardUpdate",
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
