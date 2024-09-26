const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  userPhoto: {
    type: String,
  },
  password: {
    type: String,
    required: true,
  },
  age: {
    type: Number,
  },
  gender: {
    type: String,
    enum: ["Male", "Female", "Other"],
  },
  phoneNumber: {
    type: String,
  },
  address: {
    type: String,
  },
  city: {
    type: String,
  },
  state: {
    type: String,
  },
  language: {
    type: String,
  },
  attempts: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Attempt",
    },
  ],
});

const User = mongoose.model("User", userSchema);

module.exports = User;
