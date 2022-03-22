import { apiInstance } from "./index.js";

const api = apiInstance();

function topWish(success, fail) {
  api.get(`/wish/top`).then(success).catch(fail);
}

export { topWish };
