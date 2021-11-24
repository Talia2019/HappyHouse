import { apiInstance } from "./index.js";

const api = apiInstance();

function getList(number, success, fail) {
  api.get(`/subway/list/${number}`).then(success).catch(fail);
}

async function getSubway(param, success, fail) {
  await api.get(`/subway`, { params: param }).then(success).catch(fail);
}

async function getGugunCode(name, success, fail) {
  await api.get(`/subway/gugun/${name}`).then(success).catch(fail);
}

export { getList, getSubway, getGugunCode };
