<template>
  <div>
    <b-pagination
      first-number
      last-number
      :per-page="perPage"
      :size="size"
      :value="pagevalue"
      :align="align"
      :total-rows="total"
      v-model="pagevalue"
      @input="changePageChild()"
    >
      <!-- @change="testFunction" -->
      <template v-slot:prev-text>
        <a class="page-link" aria-label="Previous">
          <span aria-hidden="true"><i class="ni ni-bold-left"></i></span>
        </a>
      </template>
      <template v-slot:next-text>
        <a class="page-link" aria-label="Next">
          <span aria-hidden="true"
            ><i class="ni ni-bold-right" aria-hidden="true"></i
          ></span>
        </a>
      </template>
    </b-pagination>
  </div>
</template>
<script>
export default {
  name: "base-pagination",
  data() {
    return {
      pagevalue: 0,
    };
  },
  created() {
    this.pagevalue = this.value;
  },
  props: {
    pageCount: {
      type: Number,
      default: 0,
      description:
        "Pagination page count. This should be specified in combination with perPage",
    },
    perPage: {
      type: Number,
      default: 10,
      description:
        "Pagination per page. Should be specified with total or pageCount",
    },
    total: {
      type: Number,
      default: 0,
      description:
        "Can be specified instead of pageCount. The page count in this case will be total/perPage",
    },
    value: {
      type: Number,
      default: 2,
      description: "Pagination value",
    },
    size: {
      type: String,
      default: "",
      description: "Pagination size",
    },
    align: {
      type: String,
      default: "",
      description: "Pagination alignment (e.g center|start|end)",
    },
  },
  // updated() {
  //   this.$nextTick(function () {
  //     console.log("updated?");
  //     this.pagevalue = this.value;
  //   });
  // },
  methods: {
    // testFunction() {
    //   console.log("자식테스트");
    //   console.log(this.value + " " + this.perPage + " " + this.pageCount);
    //   console.log(this.pagevalue);
    // },
    changePageChild() {
      // console.log("부모호출.." + this.value + " " + this.pagevalue);
      this.$emit("change-page", this.pagevalue);
    },
  },
};
</script>
