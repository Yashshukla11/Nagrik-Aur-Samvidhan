const mongoose = require("mongoose");

const attemptSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  numberOfQuestions: {
    type: Number,
    required: true,
  },
  numberOfQuestionsAttempted: {
    type: Number,
    required: true,
  },
  numberOfCorrectAnswers: {
    type: Number,
    required: true,
  },
  score: {
    type: Number,
    required: true,
  },
  questions: [
    {
      questionId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Question",
        required: true,
      },
      answer: {
        type: String,
      },
      correct: {
        type: Boolean,
      },
      correctAnswer: {
        type: String,
      },
      hintTaken: {
        type: Boolean,
        default: false,
      },
      isSubmitted: {
        type: Boolean,
        default: false,
      },
    },
  ],
  quiz: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Quiz",
  },
  caseStudy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "CaseStudy",
  },
  type: {
    type: String,
    enum: ["Quiz", "DailyQuiz", "CaseStudy"],
    required: true,
  },
  isPassed: {
    type: Boolean,
    default: false,
  },
  isSubmitted: {
    type: Boolean,
    default: false,
  },
});

const Attempt = mongoose.model("Attempt", attemptSchema);

module.exports = Attempt;
