const Router = require("express");
const {
  addQuiz,
  getQuizzesByDifficulty,
  submitQuiz,
  startQuiz,
  submitQuestion,
  getQuizMap,
  getHint,
} = require("../controllers/quiz.controllers");
const verifyToken = require("../middlewares/verifyToken");

const router = Router();

router.post("/", addQuiz);
router.get("/start/:quizId", verifyToken, startQuiz);
router.get("/hint/:attemptId", verifyToken, getHint);
router.post("/submitquestion/:attemptId", verifyToken, submitQuestion);
router.get("/submit/:attemptId", verifyToken, submitQuiz);

module.exports = router;
