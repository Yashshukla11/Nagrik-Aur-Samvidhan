const express = require('express');
const { getAllFundamentalRights } = require('../controllers/fundamentalRight.controllers.js');

const router = express.Router();

// Route to get all fundamental rights
router.get('/', getAllFundamentalRights);

module.exports = router;