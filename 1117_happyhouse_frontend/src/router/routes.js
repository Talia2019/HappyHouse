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
        redirect: "/board/list",
        children: [
          {
            path: "list",
            name: "boardList",
            component: () => import("../views/Boards/BoardList.vue"),
          },
          {
            path: "detail/:articleno",
            name: "boardView",
            component: () => import("../views/Boards/BoardView.vue"),
          },
          {
            path: "write",
            name: "boardWrite",
            component: () => import("../views/Boards/BoardWrite.vue"),
          },
          {
            path: "update/:articleno",
            name: "boardUpdate",
            component: () => import("../views/Boards/BoardUpdate.vue"),
          },
          {
            path: "delete/:articleno",
            name: "boardDelete",
            component: () => import("../views/FreeBoard.vue"),
          },
        ],
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
