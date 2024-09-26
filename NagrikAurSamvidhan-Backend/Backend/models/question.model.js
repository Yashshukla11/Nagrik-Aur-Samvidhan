const mongoose = require("mongoose");

const questionSchema = new mongoose.Schema({
  question: {
    type: String,
    required: true,
  },
  options: [
    {
      type: String,
      required: true,
    },
  ],
  correctOption: {
    type: String,
    required: true,
  },
  hint: {
    type: String,
  },
  explanation: {
    type: String,
  },
  difficulty: {
    type: String,
    enum: ["Prarambhik", "Madhyam", "Maharathi"],
  },
  type: {
    type: String,
    enum: ["Quiz", "DailyQuiz", "CaseStudy"],
  },
});

const Question = mongoose.model("Question", questionSchema);

module.exports = Question;
