const Router = require("express");

const verifyToken = require("../middlewares/verifyToken");
const {
  getMap,
  getMapByDifficulty,
} = require("../controllers/map.controllers");

const router = Router();

router.get("/", verifyToken, getMap);
router.get("/:difficulty", verifyToken, getMapByDifficulty);

module.exports = router;
