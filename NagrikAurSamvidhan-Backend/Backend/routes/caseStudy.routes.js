const Router = require("express");
const verifyToken = require("../middlewares/verifyToken");
const {
  addCaseStudy,
  startCaseStudy,
  submitQuestion,
  submitCaseStudy,
  getHint,
} = require("../controllers/caseStudy.controller");
const { getCaseStudies } = require("../controllers/map.controllers");

const router = Router();

router.post("/", addCaseStudy);
router.get("/start/:caseStudyId", verifyToken, startCaseStudy);
router.get("/hint/:attemptId", verifyToken, getHint);
router.post("/submitquestion/:attemptId", verifyToken, submitQuestion);
router.get("/submit/:attemptId", verifyToken, submitCaseStudy);
router.get("/", verifyToken, getCaseStudies);

module.exports = router;
