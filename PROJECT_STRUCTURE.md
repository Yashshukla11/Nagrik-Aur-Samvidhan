# Project Structure

## Overview

**Nagrik Aur Samvidhan** (Citizen and Constitution) is a comprehensive digital platform developed for the Smart India Hackathon to increase constitutional literacy among Indian citizens. The project consists of three main components working together to provide a seamless user experience.

## Architecture

```
Nagrik-Aur-Samvidhan/
├── NagrikAurSamvidhan-App/          # Flutter Mobile Application
├── NagrikAurSamvidhan-Backend/      # Backend Services (Node.js + Python)
├── NagrikAurSamvidhan-Web/          # React Web Application
└── README.md                         # Main project documentation
```

## Component Details

### 1. Mobile Application (NagrikAurSamvidhan-App)

**Technology Stack:**
- **Framework:** Flutter 3.3.3+
- **Language:** Dart
- **State Management:** GetX
- **UI:** Material Design with custom theming

**Key Features:**
- Cross-platform (Android, iOS, Web, Windows, Linux, macOS)
- Interactive constitutional quizzes
- Gamification with Spin the Wheel
- Text-to-Speech functionality
- Chatbot integration
- Profile-based personalized content
- Multi-language support

**Directory Structure:**
```
NagrikAurSamvidhan-App/
├── android/                 # Android-specific code
├── ios/                    # iOS-specific code
├── lib/
│   ├── Constants/          # App constants and utilities
│   ├── Elements/           # Reusable UI elements
│   ├── Services/           # API and storage services
│   ├── UI/                 # Screen components
│   │   ├── Profile/
│   │   ├── Timeline/
│   │   ├── Quiz/
│   │   ├── ChatBot/
│   │   └── ...
│   ├── Values/             # Colors, strings, styles
│   ├── themes/             # App theming
│   └── main.dart           # Application entry point
├── assets/                 # Images and static resources
├── test/                   # Unit and widget tests
└── pubspec.yaml           # Dependencies configuration
```

**Key Dependencies:**
- `get`: State management and routing
- `dio`: HTTP client for API calls
- `flutter_tts`: Text-to-speech
- `flutter_fortune_wheel`: Gamification
- `shared_preferences`: Local storage
- `flutter_secure_storage`: Secure credential storage

### 2. Backend Services (NagrikAurSamvidhan-Backend)

The backend is divided into four main services:

#### a. Main Backend (Node.js)
**Technology Stack:**
- **Runtime:** Node.js
- **Framework:** Express.js
- **Database:** MongoDB (with Mongoose ORM)
- **Authentication:** Passport.js (Google OAuth 2.0), JWT

**Directory Structure:**
```
Backend/
├── controllers/            # Business logic
├── models/                 # MongoDB schemas
├── routes/                 # API routes
├── middlewares/            # Authentication, validation
├── db/                     # Database configuration
├── utils/                  # Helper functions
├── app.js                  # Express app setup
└── index.js                # Server entry point
```

**Key Features:**
- User authentication and authorization
- Session management
- Google OAuth integration
- RESTful API endpoints
- CORS configuration

**Key Dependencies:**
- `express`: Web framework
- `mongoose`: MongoDB ODM
- `passport`: Authentication middleware
- `jsonwebtoken`: JWT tokens
- `bcrypt`: Password hashing
- `cors`: Cross-Origin Resource Sharing

#### b. AI Generation Service (Python)
**Technology Stack:**
- **Framework:** FastAPI
- **AI/ML:** LangChain, Google Generative AI, Groq
- **Database:** MongoDB (PyMongo)
- **Document Processing:** PyPDF, FAISS

**Purpose:**
- Generate simplified constitutional content
- AI-powered content summarization
- Document processing and indexing
- Vector search capabilities

**Key Dependencies:**
- `fastapi`: Modern web framework
- `langchain`: LLM application framework
- `langchain_google_genai`: Google AI integration
- `langchain_groq`: Groq AI integration
- `faiss-cpu`: Vector similarity search
- `transformers`: NLP models
- `pymongo`: MongoDB driver

#### c. ChatBot Service (Python)
**Technology Stack:**
- **Framework:** FastAPI
- **AI/ML:** LangChain, Google Generative AI, Groq
- **NLP:** Transformers
- **Document Processing:** PyPDF, FAISS

**Purpose:**
- Conversational AI chatbot
- Constitutional Q&A
- Context-aware responses
- Document-based retrieval

**Key Dependencies:**
- `fastapi`: API framework
- `langchain`: Conversational AI framework
- `langchain_groq`: LLM integration
- `langchain_google_genai`: Google AI models
- `faiss-cpu`: Semantic search
- `pypdf`: PDF processing

#### d. Translation AI Service (Python)
**Technology Stack:**
- **Framework:** FastAPI
- **AI/ML:** LangChain, Google Generative AI
- **NLP:** Transformers

**Purpose:**
- Multi-language translation
- Regional language support
- Constitutional content localization

**Key Dependencies:**
- `fastapi`: Web framework
- `transformers`: Translation models
- `langchain_google_genai`: AI translation
- `python-dotenv`: Environment configuration

### 3. Web Application (NagrikAurSamvidhan-Web)

**Technology Stack:**
- **Framework:** React 18.3.1
- **Build Tool:** Vite 5.4.1
- **Styling:** Tailwind CSS 3.4.10
- **Routing:** React Router DOM 6.26.1
- **HTTP Client:** Axios 1.7.7

**Key Features:**
- Responsive web interface
- Interactive constitutional content
- User authentication
- Quiz system
- Chatbot integration
- Article summaries
- Timeline visualization
- Indian map integration

**Directory Structure:**
```
NagrikAurSamvidhan-Web/
├── public/                 # Static assets
├── src/
│   ├── components/         # Reusable components
│   │   ├── Header.jsx
│   │   ├── Navbar.jsx
│   │   ├── Footer.jsx
│   │   ├── Login.jsx
│   │   ├── Signup.jsx
│   │   └── ...
│   ├── pages/              # Page components
│   │   ├── Home.jsx
│   │   ├── Rights.jsx
│   │   ├── Duties.jsx
│   │   ├── Preamble.jsx
│   │   ├── Quizzes.jsx
│   │   ├── Chatbot.jsx
│   │   └── ...
│   ├── login/              # Authentication context
│   ├── App.jsx             # Main app component
│   └── main.jsx            # Entry point
├── index.html              # HTML template
├── vite.config.js          # Vite configuration
└── tailwind.config.js      # Tailwind configuration
```

**Key Dependencies:**
- `react`: UI library
- `react-router-dom`: Client-side routing
- `axios`: HTTP requests
- `react-icons`: Icon library
- `react-responsive-carousel`: Image carousels
- `react-simple-maps`: Map visualization
- `swiper`: Touch slider

## Data Flow

```
┌─────────────────┐
│  Mobile App     │
│  (Flutter)      │
└────────┬────────┘
         │
         ├──────────────────┐
         │                  │
┌────────▼────────┐  ┌──────▼──────────┐
│  Web App        │  │  Backend APIs   │
│  (React)        │  │  (Express.js)   │
└────────┬────────┘  └──────┬──────────┘
         │                  │
         │            ┌─────┴─────┐
         │            │           │
         │      ┌─────▼─────┐ ┌──▼──────┐
         │      │  MongoDB  │ │ AI APIs │
         │      │ Database  │ │(FastAPI)│
         │      └───────────┘ └──┬──────┘
         │                       │
         └───────────────────────┴────────┐
                                          │
                              ┌───────────▼──────────┐
                              │  AI Services:        │
                              │  - ChatBot           │
                              │  - AI Generation     │
                              │  - Translation       │
                              └──────────────────────┘
```

## Key Concepts

### 1. Constitutional Content
The platform provides simplified access to:
- **Preamble**: Introduction to the Constitution
- **Fundamental Rights**: Articles 12-35
- **Directive Principles**: Articles 36-51
- **Fundamental Duties**: Article 51A
- **Articles**: All 395 articles with summaries
- **Amendments**: Historical changes
- **Case Studies**: Real-world applications

### 2. Gamification
- **Daily Quizzes**: Test constitutional knowledge
- **Spin the Wheel**: Interactive trivia game
- **Progress Tracking**: Monitor learning journey
- **Rewards System**: Achievements and badges

### 3. AI Features
- **Content Simplification**: Convert complex legal language to simple terms
- **Chatbot**: Ask questions about the Constitution
- **Translation**: Multi-language support for regional accessibility
- **Personalization**: Content recommendations based on user profile

### 4. User Profiles
Users can specify:
- Age group
- Education level
- Region
- Language preference
- Areas of interest

Content is tailored based on these preferences.

## Development Environment

### Prerequisites
- **Mobile App**: Flutter SDK 3.3.3+, Dart
- **Backend**: Node.js 14+, Python 3.8+
- **Web App**: Node.js 14+, npm/yarn
- **Database**: MongoDB 4.4+

### Environment Variables
Each component requires specific environment variables:
- API endpoints
- Database connections
- AI service API keys
- OAuth credentials

See individual component README files for detailed setup instructions.

## Deployment

The project supports multiple deployment options:
- **Mobile**: Play Store (Android), App Store (iOS)
- **Web**: Static hosting (Vercel, Netlify, etc.)
- **Backend**: Cloud platforms (AWS, GCP, Heroku)
- **AI Services**: Containerized deployment (Docker)

## Testing

- **Mobile**: Flutter test framework
- **Backend**: Jest/Mocha for Node.js, pytest for Python
- **Web**: React Testing Library, Vitest

## Contributing

Contributions are welcome! Please refer to DEVELOPER_GUIDE.md for:
- Code style guidelines
- Git workflow
- Pull request process
- Testing requirements

## License

This project is developed for the Smart India Hackathon 2024.

## Contact & Support

For questions or support, please refer to the main README.md or contact the development team.
