const Attempt = require("../models/attempt.model");
const Question = require("../models/question.model");
const CaseStudy = require("../models/caseStudy.model");
const User = require("../models/user.model");

// Controller to add a new case study
const addCaseStudy = async (req, res) => {
  try {
    const {
      title,
      description,
      questions,
      duration,
      totalQuestions,
      difficulty,
    } = req.body;

    // Validate required fields
    if (!title || !description || !duration || !totalQuestions) {
      return res.status(400).json({
        message:
          "Title, description, duration, and totalQuestions are required.",
      });
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

    // Create a new case study
    const newCaseStudy = new CaseStudy({
      title,
      description,
      questions,
      duration,
      totalQuestions,
      difficulty,
    });

    // Save the case study to the database
    const savedCaseStudy = await newCaseStudy.save();

    // Send the saved case study as the response
    res.status(201).json(savedCaseStudy);
  } catch (error) {
    // Handle errors
    res
      .status(500)
      .json({ message: "Error adding case study", error: error.message });
  }
};

const startCaseStudy = async (req, res) => {
  try {
    const { caseStudyId } = req.params;

    const userId = req.user._id;

    const user = await User.findById(userId);
    const caseStudy = await CaseStudy.findById(caseStudyId).populate(
      "questions",
      "-correctOption -hint -explanation"
    );
    if (!user || !caseStudy) {
      return res.status(404).json({ message: "User or Case Study not found" });
    }

    const existingAttempt = await Attempt.find({
      user: userId,
      caseStudy: caseStudyId,
    });

    // for (const attempt of existingAttempt) {
    //   if (attempt.isPassed) {
    //     return res
    //       .status(400)
    //       .json({ message: "You have already passed this case study" });
    //   }
    // }

    const attempt = new Attempt({
      user: userId,
      caseStudy: caseStudyId,
      numberOfCorrectAnswers: 0,
      numberOfQuestions: caseStudy.totalQuestions,
      numberOfQuestionsAttempted: 0,
      score: 0,
      questions: [],
      type: "CaseStudy",
      isSubmitted: false,
    });

    await attempt.save();

    res.status(200).json({
      questions: caseStudy.questions,
      attemptId: attempt._id,
      title: caseStudy.title,
      description: caseStudy.description,
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
    if (existingQuestion?.isSubmitted) {
      return res.status(400).json({ message: "Question already answered" });
    }

    const isCorrect = question.correctOption === answer;

    if (existingQuestion) {
      if (existingQuestion.isSubmitted) {
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

const submitCaseStudy = async (req, res) => {
  try {
    const { attemptId } = req.params;

    const attempt = await Attempt.findById(attemptId);

    if (!attempt) {
      return res.status(404).json({ message: "Attempt not found" });
    }

    if (attempt.isSubmitted) {
      return res.status(400).json({ message: "Case study already submitted" });
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
      title: attempt.caseStudy.title,
      difficulty: attempt.caseStudy.difficulty,
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
  addCaseStudy,
  startCaseStudy,
  getHint,
  submitQuestion,
  submitCaseStudy,
};
