import { apiInstance } from "./index.js";

const api = apiInstance();

function listNotice(param, success, fail) {
  api.get(`/notice`, { params: param }).then(success).catch(fail);
}

function writeNotice(article, success, fail) {
  api.post(`/notice`, JSON.stringify(article)).then(success).catch(fail);
}

function getNotice(articleno, success, fail) {
  api.get(`/notice/${articleno}`).then(success).catch(fail);
}

function modifyNotice(article, success, fail) {
  api.put(`/notice`, JSON.stringify(article)).then(success).catch(fail);
}

function deleteNotice(articleno, success, fail) {
  api.delete(`/notice/${articleno}`).then(success).catch(fail);
}

function searchNotice(param, success, fail) {
  api.get(`/notice`, { params: param }).then(success).catch(fail);
}

function totalNotice(param, success, fail) {
  api.get(`/notice/total`, { params: param }).then(success).catch(fail);
}

export {
  listNotice,
  writeNotice,
  getNotice,
  modifyNotice,
  deleteNotice,
  searchNotice,
  totalNotice,
};
