import { apiInstance } from "./index.js";

const api = apiInstance();

async function login(user, success, fail) {
  await api.post(`/user/login`, JSON.stringify(user)).then(success).catch(fail);
}

async function findById(userid, success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/user/info/${userid}`).then(success).catch(fail);
}

<<<<<<< HEAD
async function updateMember(user, success, fail) {
  await api.put(`/user/update`, JSON.stringify(user)).then(success).catch(fail);
=======
async function deleteMember(userid, success, fail) {
  await api.delete(`/user/${userid}`).then(success).catch(fail);
}

async function registerMember(user, success, fail) {
  await api.post(`/user`, JSON.stringify(user)).then(success).catch(fail);
}

async function updateMember(user, success, fail) {
  await api.put(`/user`, JSON.stringify(user)).then(success).catch(fail);
>>>>>>> d09d82deafe1b23619a1baab715c7818a784c0f2
}

// function logout(success, fail)

<<<<<<< HEAD
export { login, findById, updateMember };
=======
export { login, findById, deleteMember, registerMember, updateMember };
>>>>>>> d09d82deafe1b23619a1baab715c7818a784c0f2
