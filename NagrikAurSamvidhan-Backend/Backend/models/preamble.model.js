// preamble.model.js

const mongoose = require("mongoose");

const preambleSchema = new mongoose.Schema(
  {
    id: { type: String, required: true },
    en: { type: String, required: true },
    hi: { type: String, required: true },
    gu: { type: String, required: true },
    mr: { type: String, required: true },
    bn: { type: String, required: true },
    pa: { type: String, required: true },
    kn: { type: String, required: true },
    ml: { type: String, required: true },
    ta: { type: String, required: true },
  },
  { collection: "preambles" }
);

const Preamble = mongoose.model("Preamble", preambleSchema);

module.exports = Preamble;
