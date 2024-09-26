const Router = require("express");
const { addQuestion } = require("../controllers/question.controllers.js");

const router = Router();

router.post("/", addQuestion);

module.exports = router;
