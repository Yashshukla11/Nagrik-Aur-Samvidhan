const mongoose = require("mongoose");

const quizSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  questions: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Question",
    },
  ],
  duration: {
    type: Number,
    required: true,
  },
  totalQuestions: {
    type: Number,
    required: true,
  },
  difficulty: {
    type: String,
    enum: ["Prarambhik", "Madhyam", "Maharathi"],
  },
});

const Quiz = mongoose.model("Quiz", quizSchema);

module.exports = Quiz;
