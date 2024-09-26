// preamble.controllers.js

const Preamble = require("../models/preamble.model.js");

// Function to fetch all preamble data
const getAllPreambles = async (req, res) => {
  try {
    const preambles = await Preamble.find();
    res.status(200).json(preambles);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = {
  getAllPreambles,
};
