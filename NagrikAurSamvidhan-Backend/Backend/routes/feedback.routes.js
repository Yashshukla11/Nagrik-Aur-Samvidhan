const Router = require("express");
const verifyToken = require("../middlewares/verifyToken");
const {
  addFeedback,
  getFeedback,
} = require("../controllers/feedback.controller");

const router = Router();

router.post("/", verifyToken, addFeedback);
router.get("/", verifyToken, getFeedback);

module.exports = router;
