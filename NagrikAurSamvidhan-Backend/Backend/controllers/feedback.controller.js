const Feedback = require("../models/feedback.model");

// Controller function to get all fundamental rights
const addFeedback = async (req, res) => {
  try {
    const { feedback } = req.body;
    const userId = req.user.id;
    if (!feedback) {
      return res.status(400).json({ error: "Feedback is required" });
    }
    if (req.body.caseStudy) {
      const newFeedback = await Feedback.create({
        feedback,
        user: req.user,
        caseStudy: req.body.caseStudy,
      });
      newFeedback.save();
      res.status(201).json({ feedback: newFeedback });
    } else {
      const newFeedback = await Feedback.create({
        feedback,
        user: req.user,
      });
      newFeedback.save();
      res.status(201).json({ feedback: newFeedback });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getFeedback = async (req, res) => {
  try {
    const feedback = await Feedback.find();
    res.status(200).json({ feedback });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  addFeedback,
  getFeedback,
};
