const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const methodOverride = require("method-override");

const app = express();

const allowedOrigins = [
  "https://sih-2024-zeta.vercel.app",
  "http://localhost:5173",
  "http://localhost:5174",
  "http://localhost:3000",
  "http://localhost:3001",
];

app.use(
  cors({
    origin: (origin, callback) => {
      // Allow requests with no origin (like mobile apps or curl requests)
      if (!origin) return callback(null, true);

      if (allowedOrigins.indexOf(origin) !== -1) {
        // If the origin is in the allowedOrigins array
        callback(null, true);
      } else {
        // If the origin is not in the allowedOrigins array
        callback(new Error("Not allowed by CORS"));
      }
    },
    credentials: true, // Enable credentials for CORS requests
  })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(cookieParser());
app.use(methodOverride("_method"));

// routes import
const userRoutes = require("./routes/user.routes.js");
const questionRoutes = require("./routes/question.routes.js");
const quizRoutes = require("./routes/quiz.routes.js");
const mapRoutes = require("./routes/map.routes.js");
const caseStudyRoutes = require("./routes/caseStudy.routes.js");
const fundamentalRightRoutes = require("./routes/fundamentalRight.routes.js");
const preambleRoutes = require("./routes/preamble.routes.js");
const gridRoutes = require("./routes/grid.routes.js");
const feedbackRoutes = require("./routes/feedback.routes.js");

// routes declare
app.use("/user", userRoutes);
app.use("/question", questionRoutes);
app.use("/quiz", quizRoutes);
app.use("/map", mapRoutes);
app.use("/casestudy", caseStudyRoutes);
app.use("/fundamental-rights", fundamentalRightRoutes);
app.use("/preamble", preambleRoutes);
app.use("/grid", gridRoutes);
app.use("/feedback", feedbackRoutes);

app.get("/", (req, res) => {
  res.send("Yupp The server is runnng 🎉 !");
});

module.exports = app;
