const Router = require("express");
const verifyToken = require("../middlewares/verifyToken.js");
const {
  loginUser,
  registerUser,
  logoutUser,
  getUser,
  updateUser,
} = require("../controllers/user.controllers.js");

const router = Router();

router.post("/login", loginUser);
router.post("/register", registerUser);
router.get("/logout", logoutUser);
router.get("/get", getUser);
router.put("/", verifyToken, updateUser);

module.exports = router;
