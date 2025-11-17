# API Documentation - Nagrik Aur Samvidhan

This document provides comprehensive documentation for all API endpoints in the Nagrik Aur Samvidhan platform.

## Table of Contents
1. [Base URLs](#base-urls)
2. [Authentication](#authentication)
3. [Response Format](#response-format)
4. [Error Codes](#error-codes)
5. [Backend API Endpoints](#backend-api-endpoints)
6. [AI Services APIs](#ai-services-apis)

---

## Base URLs

### Development
- **Main Backend**: `http://localhost:5000`
- **ChatBot Service**: `http://localhost:8001`
- **AI Generation Service**: `http://localhost:8002`
- **Translation Service**: `http://localhost:8003`

### Production
- **Main Backend**: `https://your-backend-domain.com`
- **ChatBot Service**: `https://chatbot-service.com`
- **AI Generation Service**: `https://ai-generation-service.com`
- **Translation Service**: `https://translation-service.com`

---

## Authentication

### JWT Token Authentication
Most endpoints require authentication using JWT tokens.

#### Include Token in Requests
```http
Authorization: Bearer <your_jwt_token>
```

#### Token Storage
- **Web**: Store in localStorage or httpOnly cookies
- **Mobile**: Use FlutterSecureStorage

#### Token Expiration
- Access tokens expire after 24 hours
- Refresh tokens expire after 30 days

---

## Response Format

### Success Response
```json
{
  "success": true,
  "data": {
    // Response data
  },
  "message": "Operation successful"
}
```

### Error Response
```json
{
  "success": false,
  "error": "Error message",
  "details": {
    // Additional error details
  }
}
```

---

## Error Codes

| Status Code | Meaning |
|-------------|---------|
| 200 | OK - Request successful |
| 201 | Created - Resource created successfully |
| 400 | Bad Request - Invalid input |
| 401 | Unauthorized - Authentication required |
| 403 | Forbidden - Insufficient permissions |
| 404 | Not Found - Resource not found |
| 409 | Conflict - Resource already exists |
| 500 | Internal Server Error - Server error |

---

## Backend API Endpoints

### 1. User Management

#### Register User
```http
POST /user/register
```

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "securePassword123",
  "age": 25,
  "gender": "male",
  "state": "Maharashtra",
  "city": "Mumbai"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "_id": "user_id",
      "name": "John Doe",
      "email": "john@example.com",
      "age": 25,
      "gender": "male",
      "state": "Maharashtra",
      "city": "Mumbai"
    },
    "token": "jwt_token_here"
  },
  "message": "User registered successfully"
}
```

---

#### Login User
```http
POST /user/login
```

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "securePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "_id": "user_id",
      "name": "John Doe",
      "email": "john@example.com"
    },
    "token": "jwt_token_here"
  },
  "message": "Login successful"
}
```

---

#### Get User Profile
```http
GET /user/profile
```

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "user_id",
    "name": "John Doe",
    "email": "john@example.com",
    "age": 25,
    "gender": "male",
    "state": "Maharashtra",
    "city": "Mumbai",
    "progress": {
      "quizzesTaken": 15,
      "totalScore": 450,
      "articlesRead": 25
    }
  }
}
```

---

#### Update User Profile
```http
PUT /user/profile
```

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "name": "John Smith",
  "age": 26,
  "city": "Pune"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "user_id",
    "name": "John Smith",
    "age": 26,
    "city": "Pune"
  },
  "message": "Profile updated successfully"
}
```

---

#### Logout User
```http
POST /user/logout
```

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

---

### 2. Quiz Management

#### Get All Quizzes
```http
GET /quiz
```

**Query Parameters:**
- `category` (optional): Filter by category (e.g., "fundamental-rights", "duties")
- `difficulty` (optional): Filter by difficulty ("easy", "medium", "hard")
- `page` (optional): Page number (default: 1)
- `limit` (optional): Results per page (default: 10)

**Response:**
```json
{
  "success": true,
  "data": {
    "quizzes": [
      {
        "_id": "quiz_id",
        "title": "Fundamental Rights Quiz",
        "description": "Test your knowledge on Fundamental Rights",
        "category": "fundamental-rights",
        "difficulty": "medium",
        "totalQuestions": 10,
        "duration": 600,
        "createdAt": "2024-01-01T00:00:00.000Z"
      }
    ],
    "totalCount": 50,
    "currentPage": 1,
    "totalPages": 5
  }
}
```

---

#### Get Quiz by ID
```http
GET /quiz/:id
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "quiz_id",
    "title": "Fundamental Rights Quiz",
    "description": "Test your knowledge on Fundamental Rights",
    "category": "fundamental-rights",
    "difficulty": "medium",
    "totalQuestions": 10,
    "duration": 600,
    "questions": [
      {
        "_id": "question_id",
        "questionText": "Which Article guarantees the Right to Equality?",
        "options": [
          "Article 14",
          "Article 15",
          "Article 16",
          "Article 17"
        ],
        "correctAnswer": 0,
        "explanation": "Article 14 guarantees equality before law."
      }
    ]
  }
}
```

---

#### Submit Quiz Attempt
```http
POST /quiz/:id/submit
```

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "answers": [0, 2, 1, 3, 0],
  "timeTaken": 420
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "attemptId": "attempt_id",
    "score": 4,
    "totalQuestions": 5,
    "percentage": 80,
    "timeTaken": 420,
    "passed": true,
    "answers": [
      {
        "questionId": "q1",
        "userAnswer": 0,
        "correctAnswer": 0,
        "isCorrect": true
      }
    ]
  },
  "message": "Quiz submitted successfully"
}
```

---

#### Get Daily Quiz
```http
GET /quiz/daily
```

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "daily_quiz_id",
    "title": "Daily Constitutional Quiz",
    "date": "2024-11-17",
    "questions": [
      // Array of questions
    ],
    "alreadyAttempted": false
  }
}
```

---

### 3. Questions Management

#### Get Random Questions
```http
GET /question/random
```

**Query Parameters:**
- `count` (optional): Number of questions (default: 10)
- `category` (optional): Filter by category

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "_id": "question_id",
      "questionText": "What is the Preamble?",
      "options": [
        "Introduction to Constitution",
        "List of Articles",
        "Amendment procedure",
        "None of the above"
      ],
      "correctAnswer": 0,
      "category": "preamble",
      "difficulty": "easy"
    }
  ]
}
```

---

#### Get Question by ID
```http
GET /question/:id
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "question_id",
    "questionText": "What is the Preamble?",
    "options": ["Option 1", "Option 2", "Option 3", "Option 4"],
    "correctAnswer": 0,
    "explanation": "Detailed explanation here",
    "category": "preamble",
    "difficulty": "easy"
  }
}
```

---

### 4. Fundamental Rights

#### Get All Fundamental Rights
```http
GET /fundamental-rights
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "_id": "right_id",
      "title": "Right to Equality",
      "articleNumbers": ["14", "15", "16", "17", "18"],
      "description": "Guarantees equality before law and equal protection of laws",
      "keyPoints": [
        "Equality before law (Article 14)",
        "Prohibition of discrimination (Article 15)",
        "Equality of opportunity (Article 16)"
      ],
      "simplifiedContent": "Everyone is equal in the eyes of law"
    }
  ]
}
```

---

#### Get Fundamental Right by ID
```http
GET /fundamental-rights/:id
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "right_id",
    "title": "Right to Equality",
    "articleNumbers": ["14", "15", "16", "17", "18"],
    "description": "Detailed description",
    "keyPoints": ["Point 1", "Point 2"],
    "simplifiedContent": "Simplified explanation",
    "relatedArticles": [
      {
        "number": "14",
        "title": "Equality before law",
        "content": "Article content"
      }
    ]
  }
}
```

---

### 5. Preamble

#### Get Preamble Information
```http
GET /preamble
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "preamble_id",
    "fullText": "WE, THE PEOPLE OF INDIA...",
    "keywords": [
      {
        "word": "SOVEREIGN",
        "meaning": "India is independent and not controlled by any other nation"
      },
      {
        "word": "SOCIALIST",
        "meaning": "Equality and fair distribution of resources"
      }
    ],
    "simplifiedVersion": "Simple explanation of the Preamble",
    "importance": "Why the Preamble is important"
  }
}
```

---

### 6. Case Studies

#### Get All Case Studies
```http
GET /casestudy
```

**Query Parameters:**
- `page` (optional): Page number
- `limit` (optional): Results per page

**Response:**
```json
{
  "success": true,
  "data": {
    "caseStudies": [
      {
        "_id": "case_id",
        "title": "Kesavananda Bharati Case",
        "year": 1973,
        "summary": "Landmark case on Basic Structure doctrine",
        "articles": ["368"],
        "verdict": "Supreme Court verdict details",
        "significance": "Why this case is important",
        "category": "constitutional-amendments"
      }
    ],
    "totalCount": 25,
    "currentPage": 1
  }
}
```

---

#### Get Case Study by ID
```http
GET /casestudy/:id
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "case_id",
    "title": "Kesavananda Bharati Case",
    "year": 1973,
    "parties": "Kesavananda Bharati vs State of Kerala",
    "background": "Background of the case",
    "issues": ["Issue 1", "Issue 2"],
    "arguments": {
      "petitioner": "Arguments by petitioner",
      "respondent": "Arguments by respondent"
    },
    "verdict": "Court's decision",
    "significance": "Long-term impact",
    "relatedArticles": ["368"]
  }
}
```

---

### 7. Map/Timeline

#### Get Historical Timeline
```http
GET /map
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "_id": "event_id",
      "year": 1950,
      "date": "1950-01-26",
      "title": "Constitution of India came into effect",
      "description": "Republic Day - Constitution adopted",
      "category": "milestone",
      "significance": "Birth of the Republic of India"
    }
  ]
}
```

---

### 8. Image Grid/Library

#### Get Image Library
```http
GET /grid
```

**Query Parameters:**
- `category` (optional): Filter by category

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "_id": "image_id",
      "title": "Constituent Assembly",
      "imageUrl": "https://example.com/image.jpg",
      "description": "First meeting of Constituent Assembly",
      "category": "historical",
      "year": 1946
    }
  ]
}
```

---

### 9. Feedback

#### Submit Feedback
```http
POST /feedback
```

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "type": "bug|feature|general",
  "subject": "Feedback subject",
  "message": "Detailed feedback message",
  "rating": 4
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "_id": "feedback_id",
    "type": "bug",
    "subject": "Feedback subject",
    "status": "pending"
  },
  "message": "Feedback submitted successfully"
}
```

---

## AI Services APIs

### 1. ChatBot Service

#### Base URL
```
http://localhost:8001
```

#### Chat with Bot
```http
POST /chat
```

**Request Body:**
```json
{
  "message": "What is Article 21?",
  "userId": "user_id",
  "conversationId": "conversation_id" // optional
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "response": "Article 21 guarantees the Right to Life and Personal Liberty...",
    "conversationId": "conversation_id",
    "relatedArticles": ["21", "20"],
    "confidence": 0.95
  }
}
```

---

#### Get Conversation History
```http
GET /chat/history/:conversationId
```

**Response:**
```json
{
  "success": true,
  "data": {
    "conversationId": "conversation_id",
    "messages": [
      {
        "role": "user",
        "content": "What is Article 21?",
        "timestamp": "2024-11-17T10:00:00Z"
      },
      {
        "role": "assistant",
        "content": "Article 21 guarantees...",
        "timestamp": "2024-11-17T10:00:05Z"
      }
    ]
  }
}
```

---

### 2. AI Generation Service

#### Base URL
```
http://localhost:8002
```

#### Simplify Content
```http
POST /simplify
```

**Request Body:**
```json
{
  "content": "Complex legal text here",
  "targetAudience": "children|youth|general",
  "language": "en"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "originalContent": "Complex legal text",
    "simplifiedContent": "Simple, easy to understand version",
    "keyPoints": ["Point 1", "Point 2"],
    "complexity": "low"
  }
}
```

---

#### Generate Summary
```http
POST /summarize
```

**Request Body:**
```json
{
  "articleNumber": "21",
  "format": "brief|detailed"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "articleNumber": "21",
    "title": "Right to Life and Personal Liberty",
    "summary": "Brief or detailed summary",
    "examples": ["Example 1", "Example 2"],
    "relatedRights": ["Article 20", "Article 22"]
  }
}
```

---

#### Generate Quiz Questions
```http
POST /generate-questions
```

**Request Body:**
```json
{
  "topic": "Fundamental Rights",
  "count": 10,
  "difficulty": "easy|medium|hard"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "questions": [
      {
        "questionText": "Generated question?",
        "options": ["A", "B", "C", "D"],
        "correctAnswer": 0,
        "explanation": "Why this is correct"
      }
    ]
  }
}
```

---

### 3. Translation Service

#### Base URL
```
http://localhost:8003
```

#### Translate Content
```http
POST /translate
```

**Request Body:**
```json
{
  "content": "Text to translate",
  "targetLanguage": "hi|ta|te|bn|mr|gu|kn|ml|or|pa",
  "sourceLanguage": "en"
}
```

**Supported Languages:**
- `en` - English
- `hi` - Hindi
- `ta` - Tamil
- `te` - Telugu
- `bn` - Bengali
- `mr` - Marathi
- `gu` - Gujarati
- `kn` - Kannada
- `ml` - Malayalam
- `or` - Odia
- `pa` - Punjabi

**Response:**
```json
{
  "success": true,
  "data": {
    "originalContent": "Text to translate",
    "translatedContent": "अनुवादित पाठ",
    "sourceLanguage": "en",
    "targetLanguage": "hi"
  }
}
```

---

#### Get Supported Languages
```http
GET /languages
```

**Response:**
```json
{
  "success": true,
  "data": {
    "languages": [
      {
        "code": "en",
        "name": "English",
        "nativeName": "English"
      },
      {
        "code": "hi",
        "name": "Hindi",
        "nativeName": "हिंदी"
      }
    ]
  }
}
```

---

## Rate Limiting

### Default Limits
- **General API**: 100 requests per minute
- **AI Services**: 20 requests per minute
- **Authentication**: 10 requests per minute

### Rate Limit Headers
```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1637337600
```

---

## Webhooks (Future Implementation)

Planned webhook support for:
- Quiz completion notifications
- Achievement unlocks
- Daily quiz reminders

---

## API Versioning

Current API version: **v1**

Future versions will use URL versioning:
```
/api/v1/user/profile
/api/v2/user/profile
```

---

## SDK and Client Libraries

### JavaScript/TypeScript
```javascript
import { NagrikSamvidhanAPI } from 'nagrik-samvidhan-sdk';

const api = new NagrikSamvidhanAPI({
  baseURL: 'http://localhost:5000',
  apiKey: 'your_api_key'
});

// Get quiz
const quiz = await api.quiz.getById('quiz_id');

// Submit attempt
const result = await api.quiz.submit('quiz_id', {
  answers: [0, 1, 2],
  timeTaken: 300
});
```

### Dart/Flutter
```dart
import 'package:nagrik_samvidhan_api/nagrik_samvidhan_api.dart';

final api = NagrikSamvidhanAPI(
  baseUrl: 'http://localhost:5000',
  apiKey: 'your_api_key',
);

// Get quiz
final quiz = await api.quiz.getById('quiz_id');

// Submit attempt
final result = await api.quiz.submit('quiz_id', answers: [0, 1, 2]);
```

---

## Testing the APIs

### Using cURL

```bash
# Register user
curl -X POST http://localhost:5000/user/register \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com","password":"pass123"}'

# Login
curl -X POST http://localhost:5000/user/login \
  -H "Content-Type: application/json" \
  -d '{"email":"john@example.com","password":"pass123"}'

# Get quiz (with auth)
curl -X GET http://localhost:5000/quiz/quiz_id \
  -H "Authorization: Bearer your_token_here"
```

### Using Postman

1. Import the Postman collection (if available)
2. Set environment variables:
   - `BASE_URL`: http://localhost:5000
   - `TOKEN`: Your JWT token
3. Test endpoints

---

## Support

For API support:
- Create an issue on GitHub
- Contact the development team
- Check [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) for implementation examples

---

**Last Updated**: November 2024  
**API Version**: 1.0.0
