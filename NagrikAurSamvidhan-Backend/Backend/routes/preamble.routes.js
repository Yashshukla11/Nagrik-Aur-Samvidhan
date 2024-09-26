// preamble.routes.js

const express = require('express');
const { getAllPreambles } = require('../controllers/preamble.controllers.js');

const router = express.Router();

// Route to fetch all preamble data
router.get('/', getAllPreambles);

module.exports = router;