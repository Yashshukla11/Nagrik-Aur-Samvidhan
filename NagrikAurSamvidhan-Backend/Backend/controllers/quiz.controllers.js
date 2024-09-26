const Attempt = require("../models/attempt.model");
const Question = require("../models/question.model");
const Quiz = require("../models/quiz.model");
const User = require("../models/user.model");

// Controller to add a new quiz
const addQuiz = async (req, res) => {
  try {
    const { title, questions, duration, totalQuestions, difficulty } = req.body;

    // Validate required fields
    if (!title || !duration || !totalQuestions) {
      return res
        .status(400)
        .json({ message: "Title, duration, and totalQuestions are required." });
    }

    // Validate that each question ID exists in the database
    for (const questionId of questions) {
      const questionExists = await Question.findById(questionId);
      if (!questionExists) {
        return res
          .status(400)
          .json({ message: `Question with ID ${questionId} does not exist.` });
      }
    }

    // Create a new quiz
    const newQuiz = new Quiz({
      title,
      questions,
      duration,
      totalQuestions,
      difficulty,
    });

    // Save the quiz to the database
    const savedQuiz = await newQuiz.save();

    // Send the saved quiz as the response
    res.status(201).json(savedQuiz);
  } catch (error) {
    // Handle errors
    res
      .status(500)
      .json({ message: "Error adding quiz", error: error.message });
  }
};

const startQuiz = async (req, res) => {
  try {
    const { quizId } = req.params;

    const userId = req.user._id;

    const user = await User.findById(userId);
    const quiz = await Quiz.findById(quizId).populate(
      "questions",
      "-correctOption -hint -explanation"
    );
    console.log(quiz);
    if (!user || !quiz) {
      return res.status(404).json({ message: "User or Quiz not found" });
    }

    const existingAttempt = await Attempt.find({
      user: userId,
      quiz: quizId,
    });

    // for (const attempt of existingAttempt) {
    //   if (attempt.isPassed) {
    //     return res
    //       .status(400)
    //       .json({ message: "You have already passed this quiz" });
    //   }
    // }

    const attempt = new Attempt({
      user: userId,
      quiz: quizId,
      numberOfCorrectAnswers: 0,
      numberOfQuestions: quiz.totalQuestions,
      numberOfQuestionsAttempted: 0,
      score: 0,
      questions: [],
      type: "Quiz",
      isSubmitted: false,
    });

    await attempt.save();

    res.status(200).json({
      questions: quiz.questions,
      attemptId: attempt._id,
      title: quiz.title,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const getHint = async (req, res) => {
  try {
    const { questionId } = req.body;
    const { attemptId } = req.params;

    const attempt = await Attempt.findById(attemptId);

    if (!attempt) {
      return res.status(404).json({ message: "Attempt not found" });
    }

    const question = await Question.findById(questionId);

    if (!question) {
      return res.status(404).json({ message: "Question not found" });
    }

    for (const q of attempt.questions) {
      if (q.questionId.toString() === questionId) {
        return res
          .status(200)
          .json({ message: "Hint already taken", hint: question.hint });
      }
    }

    const newQuestion = {
      questionId,
      hintTaken: true,
    };

    attempt.questions.push(newQuestion);

    await attempt.save();

    res.status(200).json({
      success: true,
      message: "Hint taken successfully",
      hint: question.hint,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const submitQuestion = async (req, res) => {
  try {
    const { questionId, answer } = req.body;
    const { attemptId } = req.params;

    // Find the attempt and question
    const attempt = await Attempt.findById(attemptId);
    const question = await Question.findById(questionId);

    if (!attempt || !question) {
      return res.status(404).json({ message: "Attempt or Question not found" });
    }

    if (attempt.isSubmitted) {
      return res.status(400).json({ message: "Attempt already submitted" });
    }

    // Check if the question is already answered
    const existingQuestion = attempt.questions.find(
      (q) => q.questionId.toString() === questionId
    );
    console.log(existingQuestion);
    if (existingQuestion?.isSubmitted) {
      return res.status(400).json({ message: "Question already answered" });
    }

    const isCorrect = question.correctOption === answer;

    if (existingQuestion) {
      if (existingQuestion.isSubmitted) {
        console.log("question: ", existingQuestion);
        return res.status(400).json({ message: "Question already submitted" });
      }

      existingQuestion.answer = answer;
      existingQuestion.correct = isCorrect;
      existingQuestion.isSubmitted = true;

      if (isCorrect) {
        attempt.numberOfCorrectAnswers += 1;
        attempt.score += 1;
      }

      attempt.numberOfQuestionsAttempted += 1;

      await attempt.save();
      res.status(200).json({
        success: true,
        result: {
          isCorrect: isCorrect,
          correctAnswer: question.correctOption,
          yourAnswer: answer,
        },
        message: "Question submitted successfully",
      });
    } else {
      attempt.questions.push({
        questionId,
        answer: answer,
        correct: isCorrect,
        correctAnswer: question.correctOption,
        isSubmitted: true,
      });

      if (isCorrect) {
        attempt.numberOfCorrectAnswers += 1;
        attempt.score += 1;
      }

      attempt.numberOfQuestionsAttempted += 1;

      await attempt.save();

      res.status(200).json({
        success: true,
        result: {
          isCorrect: isCorrect,
          correctAnswer: question.correctOption,
          yourAnswer: answer,
        },
        message: "Question submitted successfully",
      });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const submitQuiz = async (req, res) => {
  try {
    const { attemptId } = req.params;

    const attempt = await Attempt.findById(attemptId).populate("quiz");

    if (!attempt) {
      return res.status(404).json({ message: "Attempt not found" });
    }

    if (attempt.isSubmitted) {
      return res.status(400).json({ message: "Attempt already submitted" });
    }

    attempt.isSubmitted = true;
    const percentage = (attempt.score / attempt.numberOfQuestions) * 100;
    if (percentage >= 70) {
      attempt.isPassed = true;
    } else {
      attempt.isPassed = false;
    }

    await attempt.save();

    const result = {
      numberOfCorrectAnswers: attempt.numberOfCorrectAnswers,
      score: attempt.score,
      totalQuestions: attempt.numberOfQuestions,
      title: attempt.quiz.title,
      difficulty: attempt.quiz.difficulty,
      percentage: percentage,
      type: attempt.type,
      isPassed: attempt.isPassed,
    };

    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = {
  addQuiz,
  startQuiz,
  getHint,
  submitQuestion,
  submitQuiz,
};
