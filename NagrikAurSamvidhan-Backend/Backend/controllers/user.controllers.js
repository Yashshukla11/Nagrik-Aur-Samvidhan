// const passport = require("passport");
const User = require("../models/user.model.js");
const wrapAsync = require("../utils/wrapAsync.js");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const createToken = (_id, email, isverified) => {
  return jwt.sign({ _id, email, isverified }, process.env.SECRET, {
    expiresIn: "365d",
  });
};

const registerUser = wrapAsync(async (req, res) => {
  try {
    const { email, name, age, gender, phoneNumber, language, password } =
      req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({
        success: false,
        message: "User already exists",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    let userPhoto = `https://ui-avatars.com/api/?name=${name}&background=29335C&size=128&color=fff&format=png&length=1`;

    const newUser = new User({
      email,
      name,
      age,
      gender,
      phoneNumber,
      language,
      password: hashedPassword,
      userPhoto,
    });

    const registeredUser = await newUser.save();
    const token = createToken(registeredUser._id, email, false);
    res.status(200).json({
      success: true,
      user: registeredUser,
      token,
      message: "User registered successfully",
    });
  } catch (error) {
    console.log(error.message);
    res.status(400).json({
      success: false,
      message: "Register failed",
      error: error.message,
    });
  }
});

const loginUser = wrapAsync(async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    console.log(user);
    if (!user) {
      return res
        .status(401)
        .json({ message: "user not found", success: false });
    }

    const passwordMatch = await bcrypt.compare(password, user.password);

    if (passwordMatch) {
      const token = createToken(user._id, email);
      res.status(200).json({
        success: true,
        user,
        token,
        message: "login success",
      });
    } else {
      res.status(401).json({ message: "Invalid credentials", success: false });
    }
  } catch (error) {
    res.status(500).json({ message: "Internal Server Error", success: false });
  }
});

const logoutUser = async (req, res) => {
  try {
    res.clearCookie("token");

    res.status(200).json({
      success: true,
      message: "Logout successful",
    });
  } catch (error) {
    res.status(500).json({
      message: "Internal Server Error",
      error: error.message,
      success: false,
    });
  }
};

// Get a user
const getUser = wrapAsync(async (req, res) => {
  // Retrieve the token from the request headers
  const token =
    req.cookies.token ||
    (req.headers.authorization && req.headers.authorization.split(" ")[1]);
  if (!token) {
    return res.status(401).json({
      message: "Unauthorized",
      success: false,
    });
  }

  jwt.verify(token, process.env.SECRET, {}, async (err, decoded) => {
    if (err) {
      return res.status(404).json({
        message: "Failed to verify token",
        error: err.message,
        success: false,
      });
    }

    try {
      // Assuming you have a User model with findById method
      const user = await User.findById(decoded._id).select("-password");
      if (!user) {
        return res.status(404).json({
          message: "User not found",
          success: false,
        });
      }

      res.status(200).json(user);
    } catch (error) {
      res.status(500).json({
        message: "Internal server error",
        error: error.message,
        success: false,
      });
    }
  });
});

const updateUser = wrapAsync(async (req, res) => {
  try {
    const {
      name,
      password,
      age,
      gender,
      phoneNumber,
      address,
      city,
      state,
      language,
    } = req.body;
    const user = await User.findById(req.user._id);

    if (!user) {
      return res.status(404).json({
        message: "User not found",
        success: false,
      });
    }

    if (name) {
      user.name = name;
    }

    if (password) {
      const hashedPassword = await bcrypt.hash(password, 10);
      user.password = hashedPassword;
    }

    if (age) {
      user.age = age;
    }

    if (gender) {
      user.gender = gender;
    }

    if (phoneNumber) {
      user.phoneNumber = phoneNumber;
    }

    if (address) {
      user.address = address;
    }

    if (city) {
      user.city = city;
    }

    if (state) {
      user.state = state;
    }

    if (language) {
      user.language = language;
    }

    const updatedUser = await user.save();

    res.status(200).json({
      success: true,
      user: updatedUser,
      message: "User updated successfully",
    });
  } catch (error) {
    res.status(500).json({
      message: "Internal server error",
      error: error.message,
      success: false,
    });
  }
});

module.exports = {
  registerUser,
  loginUser,
  logoutUser,
  getUser,
  updateUser,
};
