<template>
  <div>
    <div>
      <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
        <b-row>
          <b-col xl="3" md="6"> </b-col>
        </b-row>
      </base-header>
      <b-container fluid class="mt--7">
        <b-row>
          <b-col>
            <light-table />
          </b-col>
        </b-row>
        <div class="mt-5"></div>
        <!-- <dark-table></dark-table> -->
      </b-container>
    </div>
    <!-- <div>
      <b-container class="bv-example-row mt-3">
        <b-row>
          <b-col>
            <b-alert show><h3>글목록</h3></b-alert>
          </b-col>
        </b-row>
        <b-row class="mb-1">
          <b-col class="text-right">
            <b-button variant="outline-primary" @click="moveWrite()"
              >글쓰기</b-button
            >
          </b-col>
        </b-row>
        <b-row>
          <b-col>
            <b-table striped hover :items="articles" :fields="fields"> -->
    <!-- @row-clicked="viewArticle" -->
    <!-- <template #cell(subject)="data">
              <router-link
                :to="{
                  name: 'BoardView',
                  params: { articleno: data.item.articleno },
                }"
                >{{ data.item.subject }}</router-link
              >
            </template> -->
    <!-- </b-table>
          </b-col>
        </b-row>
      </b-container>
    </div> -->
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
import projects from "./Tables/projects";
import users from "./Tables/users";
import LightTable from "./Tables/RegularTables/LightTable";
// import DarkTable from "./Tables/RegularTables/DarkTable";

export default {
  name: "Board",
  components: {
    LightTable,
    // DarkTable,
    [Dropdown.name]: Dropdown,
    [DropdownItem.name]: DropdownItem,
    [DropdownMenu.name]: DropdownMenu,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn,
  },
  data() {
    return {
      projects,
      users,
    };
  },
};
</script>

<style></style>
