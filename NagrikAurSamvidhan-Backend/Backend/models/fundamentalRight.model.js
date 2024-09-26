const mongoose = require("mongoose");

const fundamentalRightSchema = new mongoose.Schema({
  id: {
    type: String,
    required: true,
  },
  en: {
    type: String,
    required: true,
  },
  hi: {
    type: String,
    required: true,
  },
  bn: {
    type: String,
    required: true,
  },
  gu: {
    type: String,
    required: true,
  },
  kn: {
    type: String,
    required: true,
  },
  ml: {
    type: String,
    required: true,
  },
  mr: {
    type: String,
    required: true,
  },
  pa: {
    type: String,
    required: true,
  },
  tl: {
    type: String,
    required: true,
  },
});

const FundamentalRight = mongoose.model("FundamentalRight", fundamentalRightSchema);

module.exports = FundamentalRight;