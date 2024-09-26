const Grid = require("../models/grid.model");

const addGrid = async (req, res) => {
  try {
    const grid = new Grid({
      title: req.body.title,
      type: req.body.type,
      image: req.body.image,
    });
    await grid.save();
    res.status(201).json(grid);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const deleteGrid = async (req, res) => {
  try {
    const grid = await Grid.findByIdAndDelete(req.params.id);
    if (!grid) {
      res.status(404).json({ message: "Grid not found" });
    }
    res.status(200).json({ message: "Grid deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const getGrids = async (req, res) => {
  try {
    const grid = await Grid.find({});
    if (!grid) {
      res.status(404).json({ message: "Grid not found" });
    }
    res.status(200).json(grid);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = {
  addGrid,
  deleteGrid,
  getGrids,
};
