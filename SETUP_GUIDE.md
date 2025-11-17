# Setup Guide - Nagrik Aur Samvidhan

This guide provides step-by-step instructions to set up all components of the Nagrik Aur Samvidhan project on your local development environment.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [MongoDB Setup](#mongodb-setup)
3. [Backend Setup (Node.js)](#backend-setup-nodejs)
4. [AI Services Setup (Python)](#ai-services-setup-python)
5. [Web Application Setup](#web-application-setup)
6. [Mobile Application Setup](#mobile-application-setup)
7. [Environment Variables](#environment-variables)
8. [Running the Complete Stack](#running-the-complete-stack)
9. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software

#### For All Components
- **Git**: Version control
  ```bash
  # Verify installation
  git --version
  ```

#### For Backend (Node.js)
- **Node.js**: v14.x or higher
- **npm**: v6.x or higher (comes with Node.js)
  ```bash
  # Verify installation
  node --version
  npm --version
  ```

#### For AI Services (Python)
- **Python**: v3.8 or higher
- **pip**: Python package manager
  ```bash
  # Verify installation
  python --version
  # or
  python3 --version
  
  pip --version
  # or
  pip3 --version
  ```

#### For Mobile App (Flutter)
- **Flutter SDK**: v3.3.3 or higher
- **Android Studio** (for Android development)
- **Xcode** (for iOS development - macOS only)
  ```bash
  # Verify installation
  flutter --version
  flutter doctor
  ```

#### Database
- **MongoDB**: v4.4 or higher
  - Option 1: Local installation
  - Option 2: MongoDB Atlas (cloud)

---

## MongoDB Setup

### Option 1: Local MongoDB Installation

#### Windows
1. Download MongoDB Community Server from [mongodb.com](https://www.mongodb.com/try/download/community)
2. Install and follow the installation wizard
3. Start MongoDB service:
   ```bash
   net start MongoDB
   ```

#### macOS
```bash
# Using Homebrew
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community
```

#### Linux (Ubuntu/Debian)
```bash
# Import MongoDB public GPG key
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

# Create list file
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Install MongoDB
sudo apt-get update
sudo apt-get install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod
```

### Option 2: MongoDB Atlas (Cloud)
1. Create account at [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
2. Create a new cluster (free tier available)
3. Get connection string
4. Whitelist your IP address

---

## Backend Setup (Node.js)

### 1. Navigate to Backend Directory
```bash
cd NagrikAurSamvidhan-Backend/Backend
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Configure Environment Variables
Create a `.env` file in the `Backend` directory:

```bash
cp .env.sample .env
```

Edit `.env` with your configuration:
```env
# Server Configuration
PORT=5000
NODE_ENV=development

# Database
MONGODB_URI=mongodb://localhost:27017/nagrik_samvidhan
# Or for MongoDB Atlas:
# MONGODB_URI=mongodb+srv://<username>:<password>@cluster.mongodb.net/nagrik_samvidhan

# JWT Secret
JWT_SECRET=your_jwt_secret_key_here_minimum_32_characters

# Session Secret
SESSION_SECRET=your_session_secret_here

# Google OAuth (Optional)
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
GOOGLE_CALLBACK_URL=http://localhost:5000/auth/google/callback

# CORS Origin
CORS_ORIGIN=http://localhost:3000,http://localhost:5173
```

### 4. Start the Server
```bash
# Development mode with auto-reload
npm run dev

# Or production mode
npm start
```

The backend should now be running on `http://localhost:5000`

---

## AI Services Setup (Python)

All three AI services (ChatBot, AI Generation, Translation) follow similar setup steps.

### 1. Create Python Virtual Environment

#### For ChatBot Service
```bash
cd NagrikAurSamvidhan-Backend/ChatBot

# Create virtual environment
python -m venv venv
# or
python3 -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

#### For AI Generation Service
```bash
cd NagrikAurSamvidhan-Backend/AIGeneration

# Create and activate virtual environment (same as above)
python -m venv venv
source venv/bin/activate  # macOS/Linux
# or
venv\Scripts\activate  # Windows
```

#### For Translation Service
```bash
cd NagrikAurSamvidhan-Backend/TranslationAI

# Create and activate virtual environment
python -m venv venv
source venv/bin/activate  # macOS/Linux
# or
venv\Scripts\activate  # Windows
```

### 2. Install Dependencies

For each service, install requirements:
```bash
pip install -r requirements.txt
# or
pip3 install -r requirements.txt
```

### 3. Configure Environment Variables

Create `.env` file in each service directory:

**ChatBot/.env:**
```env
# API Keys
GROQ_API_KEY=your_groq_api_key_here
GOOGLE_API_KEY=your_google_ai_api_key_here

# Server Configuration
PORT=8001
HOST=0.0.0.0

# MongoDB (if needed)
MONGODB_URI=mongodb://localhost:27017/nagrik_samvidhan
```

**AIGeneration/.env:**
```env
# API Keys
GROQ_API_KEY=your_groq_api_key_here
GOOGLE_API_KEY=your_google_ai_api_key_here

# Server Configuration
PORT=8002
HOST=0.0.0.0

# MongoDB
MONGODB_URI=mongodb://localhost:27017/nagrik_samvidhan
```

**TranslationAI/.env:**
```env
# API Keys
GOOGLE_API_KEY=your_google_ai_api_key_here

# Server Configuration
PORT=8003
HOST=0.0.0.0
```

### 4. Start AI Services

For each service:
```bash
# Make sure virtual environment is activated
uvicorn main:app --reload --port 8001  # ChatBot
# or
uvicorn main:app --reload --port 8002  # AI Generation
# or
uvicorn main:app --reload --port 8003  # Translation
```

**Services should be running on:**
- ChatBot: `http://localhost:8001`
- AI Generation: `http://localhost:8002`
- Translation: `http://localhost:8003`

---

## Web Application Setup

### 1. Navigate to Web Directory
```bash
cd NagrikAurSamvidhan-Web
```

### 2. Install Dependencies
```bash
npm install
# or
yarn install
```

### 3. Configure Environment Variables

Create `.env` file in the root of `NagrikAurSamvidhan-Web`:
```env
# API Endpoints
VITE_API_URL=http://localhost:5000
VITE_CHATBOT_URL=http://localhost:8001
VITE_AI_GENERATION_URL=http://localhost:8002
VITE_TRANSLATION_URL=http://localhost:8003

# App Configuration
VITE_APP_NAME=Nagrik Aur Samvidhan
VITE_APP_VERSION=1.0.0
```

### 4. Start Development Server
```bash
npm run dev
# or
yarn dev
```

The web app should be running on `http://localhost:5173` (Vite default) or `http://localhost:3000`

### 5. Build for Production
```bash
npm run build
# or
yarn build
```

Preview production build:
```bash
npm run preview
# or
yarn preview
```

---

## Mobile Application Setup

### 1. Navigate to App Directory
```bash
cd NagrikAurSamvidhan-App
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Configure API Endpoints

Edit the file `lib/Constants/Utils/app_urls.dart` to set your API endpoints:
```dart
class AppUrls {
  static const String baseUrl = 'http://localhost:5000';  // or your backend URL
  static const String chatbotUrl = 'http://localhost:8001';
  static const String aiGenerationUrl = 'http://localhost:8002';
  static const String translationUrl = 'http://localhost:8003';
  
  // Add other endpoints as needed
}
```

**Note:** For physical devices or emulators:
- Android Emulator: Use `http://10.0.2.2:5000` instead of `localhost:5000`
- iOS Simulator: Use `http://localhost:5000` or your computer's IP
- Physical Device: Use your computer's local network IP (e.g., `http://192.168.1.100:5000`)

### 4. Run Flutter Doctor
```bash
flutter doctor
```

Fix any issues reported by Flutter Doctor.

### 5. Run the Application

#### On Android Emulator/Device
```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run in release mode
flutter run --release
```

#### On iOS Simulator (macOS only)
```bash
# Open iOS Simulator
open -a Simulator

# Run the app
flutter run

# Or specify device
flutter run -d "iPhone 14"
```

#### On Web
```bash
flutter run -d chrome
# or
flutter run -d web-server
```

#### On Desktop (Windows/macOS/Linux)
```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

### 6. Build for Production

#### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

#### iOS (macOS only)
```bash
flutter build ios --release
# Then open in Xcode for signing and distribution
```

---

## Environment Variables

### Summary of Required API Keys

1. **Google AI API Key**
   - Get from: [makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)
   - Used in: AI Generation, ChatBot, Translation services

2. **Groq API Key**
   - Get from: [console.groq.com](https://console.groq.com/)
   - Used in: AI Generation, ChatBot services

3. **Google OAuth Credentials** (Optional)
   - Get from: [console.cloud.google.com](https://console.cloud.google.com/)
   - Used in: Backend authentication

4. **MongoDB URI**
   - Local: `mongodb://localhost:27017/nagrik_samvidhan`
   - Atlas: Get from MongoDB Atlas dashboard

---

## Running the Complete Stack

### Start All Services (Recommended Order)

1. **Start MongoDB** (if running locally)
   ```bash
   # Already started in setup, verify it's running
   # Windows: Check Services
   # macOS/Linux:
   sudo systemctl status mongod
   ```

2. **Start Backend (Node.js)**
   ```bash
   cd NagrikAurSamvidhan-Backend/Backend
   npm run dev
   # Should run on http://localhost:5000
   ```

3. **Start AI Services (Python)**
   
   Open 3 separate terminal windows:
   
   Terminal 1 - ChatBot:
   ```bash
   cd NagrikAurSamvidhan-Backend/ChatBot
   source venv/bin/activate  # or venv\Scripts\activate on Windows
   uvicorn main:app --reload --port 8001
   ```
   
   Terminal 2 - AI Generation:
   ```bash
   cd NagrikAurSamvidhan-Backend/AIGeneration
   source venv/bin/activate
   uvicorn main:app --reload --port 8002
   ```
   
   Terminal 3 - Translation:
   ```bash
   cd NagrikAurSamvidhan-Backend/TranslationAI
   source venv/bin/activate
   uvicorn main:app --reload --port 8003
   ```

4. **Start Web Application**
   ```bash
   cd NagrikAurSamvidhan-Web
   npm run dev
   # Should run on http://localhost:5173
   ```

5. **Start Mobile Application**
   ```bash
   cd NagrikAurSamvidhan-App
   flutter run
   ```

### Quick Start Script (Linux/macOS)

Create a file `start-all.sh`:
```bash
#!/bin/bash

# Start Backend
cd NagrikAurSamvidhan-Backend/Backend
npm run dev &

# Start ChatBot
cd ../ChatBot
source venv/bin/activate
uvicorn main:app --reload --port 8001 &

# Start AI Generation
cd ../AIGeneration
source venv/bin/activate
uvicorn main:app --reload --port 8002 &

# Start Translation
cd ../TranslationAI
source venv/bin/activate
uvicorn main:app --reload --port 8003 &

# Start Web App
cd ../../NagrikAurSamvidhan-Web
npm run dev &

echo "All services started!"
```

Make executable and run:
```bash
chmod +x start-all.sh
./start-all.sh
```

---

## Troubleshooting

### Common Issues

#### 1. Port Already in Use
```bash
# Find process using port (e.g., 5000)
# Linux/macOS:
lsof -i :5000
# Windows:
netstat -ano | findstr :5000

# Kill process
# Linux/macOS:
kill -9 <PID>
# Windows:
taskkill /PID <PID> /F
```

#### 2. MongoDB Connection Failed
- Verify MongoDB is running
- Check connection string in `.env`
- For Atlas, ensure IP is whitelisted
- Check firewall settings

#### 3. Module Not Found (Node.js)
```bash
# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

#### 4. Python Package Installation Failed
```bash
# Upgrade pip
pip install --upgrade pip

# Install with verbose output
pip install -r requirements.txt -v

# If specific package fails, install individually
pip install package_name
```

#### 5. Flutter Build Failed
```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

#### 6. API Key Issues
- Verify API keys are correctly set in `.env` files
- Check for extra spaces or quotes
- Ensure `.env` file is in the correct directory
- Restart the service after updating `.env`

#### 7. CORS Errors
- Update `CORS_ORIGIN` in backend `.env`
- Ensure frontend URL is included
- Restart backend after changes

### Getting Help

If you encounter issues not covered here:
1. Check the specific component's README
2. Review error logs carefully
3. Search existing issues on GitHub
4. Create a new issue with:
   - Error message
   - Steps to reproduce
   - Environment details (OS, versions, etc.)

---

## Next Steps

After successful setup:
1. Read [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) for development guidelines
2. Review [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) to understand the architecture
3. Check [API_DOCUMENTATION.md](API_DOCUMENTATION.md) for API details
4. Start contributing!

---

## Verification Checklist

- [ ] MongoDB is running and accessible
- [ ] Backend (Node.js) is running on port 5000
- [ ] ChatBot service is running on port 8001
- [ ] AI Generation service is running on port 8002
- [ ] Translation service is running on port 8003
- [ ] Web app is accessible in browser
- [ ] Mobile app runs on emulator/device
- [ ] API endpoints are correctly configured
- [ ] All environment variables are set
- [ ] No CORS errors in browser console

If all items are checked, you're ready to develop! 🎉
