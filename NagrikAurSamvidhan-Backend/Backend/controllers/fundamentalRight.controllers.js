const FundamentalRight = require('../models/fundamentalRight.model.js');

// Controller function to get all fundamental rights
const getAllFundamentalRights = async (req, res) => {
  try {
    const fundamentalRights = await FundamentalRight.find();
    res.status(200).json(fundamentalRights);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = {
  getAllFundamentalRights,
};