const Question = require("../models/question.model");

// Controller to add a new question
const addQuestion = async (req, res) => {
  try {
    const {
      question,
      options,
      correctOption,
      hint,
      explanation,
      difficulty,
      type,
    } = req.body;

    // Validate required fields
    if (!question || !options || !correctOption) {
      return res.status(400).json({
        message: "Question, options, and correctOption are required.",
      });
    }

    // Create a new question
    const newQuestion = new Question({
      question,
      options,
      correctOption,
      hint,
      explanation,
      difficulty,
      type,
    });

    // Save the question to the database
    const savedQuestion = await newQuestion.save();

    // Send the saved question as the response
    res.status(201).json(savedQuestion);
  } catch (error) {
    // Handle errors
    res
      .status(500)
      .json({ message: "Error adding question", error: error.message });
  }
};

module.exports = { addQuestion };
