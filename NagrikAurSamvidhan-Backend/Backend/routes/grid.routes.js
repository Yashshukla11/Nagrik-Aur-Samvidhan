const Router = require("express");
const {
  addGrid,
  deleteGrid,
  getGrids,
} = require("../controllers/grid.controller");

const router = Router();

router.post("/", addGrid);
router.delete("/:id", deleteGrid);
router.get("/", getGrids);

module.exports = router;
