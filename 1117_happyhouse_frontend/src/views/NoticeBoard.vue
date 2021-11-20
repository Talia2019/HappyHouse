<template>
  <div>
    <div>
      <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
        <b-row> </b-row>
      </base-header>
      <b-container fluid class="mt--7">
        <b-row>
          <b-col>
            <router-view />
          </b-col>
        </b-row>
        <div class="mt-5"></div>
      </b-container>
    </div>
  </div>
</template>

<script>
import {
  Dropdown,
  DropdownItem,
  DropdownMenu,
  Table,
  TableColumn,
} from "element-ui";

export default {
  name: "Board",
  components: {
    [Dropdown.name]: Dropdown,
    [DropdownItem.name]: DropdownItem,
    [DropdownMenu.name]: DropdownMenu,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn,
  },
  data() {
    return {};
  },
};
</script>

<style>
.bg-success {
  background: #2186c4 !important;
}
</style>
