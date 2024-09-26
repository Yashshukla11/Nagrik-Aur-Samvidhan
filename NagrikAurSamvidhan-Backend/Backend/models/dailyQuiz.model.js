const mongoose = require("mongoose");

const dailyQuizSchema = new mongoose.Schema({
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

module.exports = mongoose.model("DailyQuiz", dailyQuizSchema);
