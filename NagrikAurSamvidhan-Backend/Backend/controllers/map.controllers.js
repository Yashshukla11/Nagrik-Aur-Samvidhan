const Attempt = require("../models/attempt.model");
const CaseStudy = require("../models/caseStudy.model");
const Quiz = require("../models/quiz.model");

const getMap = async (req, res) => {
  try {
    const quizDifficulties = Quiz.schema.path("difficulty").enumValues;
    const caseStudyDifficulties =
      CaseStudy.schema.path("difficulty").enumValues;
    const difficultyMap = {};

    let prarambhikPassedPercentage = 0;
    let madhyamPassedPercentage = 0;

    const difficulties = [
      ...new Set([...quizDifficulties, ...caseStudyDifficulties]),
    ];

    for (const difficulty of difficulties) {
      const [quizzes, caseStudies] = await Promise.all([
        Quiz.find({ difficulty }).select("-questions -__v"),
        CaseStudy.find({ difficulty }).select("-questions -__v"),
      ]);

      const totalQuizCount = quizzes.length;
      const totalCaseStudyCount = caseStudies.length;

      let totalPassedQuizCount = 0;
      let totalPassedCaseStudyCount = 0;

      if (totalQuizCount > 0) {
        for (const quiz of quizzes) {
          const passedAttempts = await Attempt.countDocuments({
            quiz: quiz._id,
            isPassed: true,
          });

          if (passedAttempts > 0) {
            totalPassedQuizCount += 1;
          }
        }
      }

      if (totalCaseStudyCount > 0) {
        for (const caseStudy of caseStudies) {
          const passedAttempts = await Attempt.countDocuments({
            quiz: caseStudy._id,
            isPassed: true,
          });

          if (passedAttempts > 0) {
            totalPassedCaseStudyCount += 1;
          }
        }
      }

      const totalPassed = totalPassedQuizCount + totalPassedCaseStudyCount;
      const totalCount = totalQuizCount + totalCaseStudyCount;

      const passPercentage =
        totalCount > 0 ? (totalPassed / totalCount) * 100 : 0;

      if (difficulty === "Prarambhik") {
        prarambhikPassedPercentage = passPercentage;
      }

      if (difficulty === "Madhyam") {
        madhyamPassedPercentage = passPercentage;
      }

      difficultyMap[difficulty] = {
        totalQuizCount,
        totalCaseStudyCount,
        totalPassedCount: totalPassed,
        isLocked: true,
        completionPercentage: passPercentage.toFixed(0),
      };
    }

    if (difficultyMap["Prarambhik"]) {
      difficultyMap["Prarambhik"].isLocked = false;
    }

    if (difficultyMap["Madhyam"] && prarambhikPassedPercentage >= 70) {
      difficultyMap["Madhyam"].isLocked = false;
    }

    if (difficultyMap["Maharathi"] && madhyamPassedPercentage >= 70) {
      difficultyMap["Maharathi"].isLocked = false;
    }

    res.status(200).json(difficultyMap);
  } catch (error) {
    res.status(500).json({ message: "Server error", error });
  }
};

const getMapByDifficulty = async (req, res) => {
  try {
    const { difficulty } = req.params;
    if (!["Prarambhik", "Madhyam", "Maharathi"].includes(difficulty)) {
      return res.status(400).json({ message: "Invalid difficulty level" });
    }

    // Fetch quizzes based on difficulty
    const quizzes = await Quiz.find({ difficulty }).select("-questions -__v");
    const caseStudies = await CaseStudy.find({ difficulty }).select(
      "-questions -__v"
    );

    // Prepare an array to hold the response data
    const mapData = [];

    for (const quiz of quizzes) {
      const attempts = await Attempt.find({ quiz: quiz._id });

      // Default values for the quiz status
      let isPassed = false;
      let isAttempted = attempts.length > 0;
      let score = attempts.length > 0 ? attempts[0].score : 0;
      let percentage =
        attempts.length > 0 ? (score / quiz.totalQuestions) * 100 : 0;

      // Iterate over attempts to check if the quiz is passed and to calculate score and percentage
      attempts.sort((a, b) => b.score - a.score);
      console.log(attempts);
      for (const attempt of attempts) {
        if (attempt.isPassed) {
          isPassed = true;
          score = attempt.score;
          percentage = (score / attempt.numberOfQuestions) * 100;
          break; // Once we find a passed attempt, no need to continue checking
        }
      }

      // Push quiz data along with additional properties into the response array
      if (isAttempted) {
        mapData.push({
          _id: quiz._id,
          title: quiz.title,
          duration: quiz.duration,
          totalQuestions: quiz.totalQuestions,
          difficulty: quiz.difficulty,
          isPassed,
          isAttempted,
          score: attempts[0].score,
          percentage: (attempts[0].score / quiz.totalQuestions) * 100,
          type: "Quiz",
        });
      } else {
        mapData.push({
          _id: quiz._id,
          title: quiz.title,
          duration: quiz.duration,
          totalQuestions: quiz.totalQuestions,
          difficulty: quiz.difficulty,
          type: "Quiz",
        });
      }
    }

    for (const caseStudy of caseStudies) {
      const attempts = await Attempt.find({ caseStudy: caseStudy._id });

      // Default values for the quiz status
      let isPassed = false;
      let isAttempted = attempts.length > 0;
      let score = attempts.length > 0 ? attempts[0].score : 0;
      let percentage =
        attempts.length > 0 ? (score / caseStudy.totalQuestions) * 100 : 0;

      // Iterate over attempts to check if the quiz is passed and to calculate score and percentage
      for (const attempt of attempts) {
        if (attempt.isPassed) {
          isPassed = true;
          score = attempt.score;
          percentage = (score / attempt.numberOfQuestions) * 100;
          break; // Once we find a passed attempt, no need to continue checking
        }
      }

      // Push quiz data along with additional properties into the response array
      if (isAttempted) {
        mapData.push({
          _id: caseStudy._id,
          title: caseStudy.title,
          duration: caseStudy.duration,
          description: caseStudy.description,
          totalQuestions: caseStudy.totalQuestions,
          difficulty: caseStudy.difficulty,
          isPassed,
          isAttempted,
          score,
          percentage: percentage.toFixed(0),
          type: "CaseStudy",
        });
      } else {
        mapData.push({
          _id: caseStudy._id,
          title: caseStudy.title,
          description: caseStudy.description,
          duration: caseStudy.duration,
          totalQuestions: caseStudy.totalQuestions,
          difficulty: caseStudy.difficulty,
          type: "CaseStudy",
        });
      }
    }

    res.status(200).json(mapData);
  } catch (error) {
    res.status(500).json({ message: "Server error", error });
  }
};

const getCaseStudies = async (req, res) => {
  try {
    const caseStudies = await CaseStudy.find().select("-questions -__v");
    const mapData = [];

    for (const caseStudy of caseStudies) {
      const attempts = await Attempt.find({ caseStudy: caseStudy._id });

      // Default values for the quiz status
      let isPassed = false;
      let isAttempted = attempts.length > 0;
      let score = attempts.length > 0 ? attempts[0].score : 0;
      let percentage =
        attempts.length > 0 ? (score / caseStudy.totalQuestions) * 100 : 0;

      // Iterate over attempts to check if the quiz is passed and to calculate score and percentage
      for (const attempt of attempts) {
        if (attempt.isPassed) {
          isPassed = true;
          score = attempt.score;
          percentage = (score / attempt.numberOfQuestions) * 100;
          break; // Once we find a passed attempt, no need to continue checking
        }
      }

      // Push quiz data along with additional properties into the response array
      if (isAttempted) {
        mapData.push({
          _id: caseStudy._id,
          title: caseStudy.title,
          duration: caseStudy.duration,
          description: caseStudy.description,
          totalQuestions: caseStudy.totalQuestions,
          difficulty: caseStudy.difficulty,
          isPassed,
          isAttempted,
          score,
          percentage: percentage.toFixed(0),
          type: "CaseStudy",
          image: caseStudy.image,
          url: caseStudy.url,
        });
      } else {
        mapData.push({
          _id: caseStudy._id,
          title: caseStudy.title,
          description: caseStudy.description,
          duration: caseStudy.duration,
          totalQuestions: caseStudy.totalQuestions,
          difficulty: caseStudy.difficulty,
          type: "CaseStudy",
          image: caseStudy.image,
          url: caseStudy.url,
        });
      }
    }
    res.status(200).json(mapData);
  } catch (error) {
    res.status(500).json({ message: "Server error", error });
  }
};

module.exports = {
  getMap,
  getMapByDifficulty,
  getCaseStudies,
};
