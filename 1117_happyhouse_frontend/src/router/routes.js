import DashboardLayout from "@/views/Layout/DashboardLayout.vue";
import AuthLayout from "@/views/Pages/AuthLayout.vue";

import NotFound from "@/views/NotFoundPage.vue";

const routes = [
  {
    path: "/",
    redirect: "dashboard",
    component: DashboardLayout,
    children: [
      {
        path: "/dashboard",
        name: "dashboard",
        component: () => import("../views/Dashboard.vue"),
      },
      {
        path: "/profile",
        name: "profile",
        component: () => import("../views/Pages/UserProfile.vue"),
      },
      {
        path: "/maps",
        name: "maps",
        component: () => import("../views/KakaoMaps.vue"),
      },
      {
        path: "/tables",
        name: "tables",
        component: () => import("../views/RegularTables.vue"),
      },
      {
        path: "/board",
        name: "boards",
        component: () => import("../views/FreeBoard.vue"),
        // redirect: "/board/list",
        // children: [
        //   {
        //     path: "list",
        //     name: "BoardList",
        //     component: BoardList,
        //   },
        //   {
        //     path: "write",
        //     name: "BoardWrite",
        //     component: BoardWrite,
        //   },
        //   {
        //     path: "detail/:articleno",
        //     name: "BoardView",
        //     component: BoardView,
        //   },
        //   {
        //     path: "update/:articleno",
        //     name: "BoardUpdate",
        //     component: BoardUpdate,
        //   },
        //   {
        //     path: "delete/:articleno",
        //     name: "BoardDelete",
        //     component: BoardDelete,
        //   },
        // ],
      },
    ],
  },
  {
    path: "/",
    redirect: "login",
    component: AuthLayout,
    children: [
      {
        path: "/login",
        name: "login",
        component: () => import("../views/Pages/Login.vue"),
      },
      {
        path: "/register",
        name: "register",
        component: () => import("../views/Pages/Register.vue"),
      },
      { path: "*", component: NotFound },
    ],
  },
];

export default routes;
