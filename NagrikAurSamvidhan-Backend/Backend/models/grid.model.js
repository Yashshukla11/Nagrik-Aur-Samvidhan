const mongoose = require("mongoose");

const gridSchema = new mongoose.Schema({
  image: {
    type: String,
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  type: {
    type: String,
    required: true,
  },
});

const Grid = mongoose.model("Grid", gridSchema);

module.exports = Grid;
