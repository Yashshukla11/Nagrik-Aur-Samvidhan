# Developer Guide - Nagrik Aur Samvidhan

This guide helps developers understand how to contribute to the Nagrik Aur Samvidhan project effectively.

## Table of Contents
1. [Getting Started](#getting-started)
2. [Development Workflow](#development-workflow)
3. [Code Organization](#code-organization)
4. [Coding Standards](#coding-standards)
5. [Testing](#testing)
6. [API Integration](#api-integration)
7. [State Management](#state-management)
8. [Best Practices](#best-practices)
9. [Common Development Tasks](#common-development-tasks)
10. [Contributing Guidelines](#contributing-guidelines)

---

## Getting Started

### Prerequisites
Before you begin development, ensure you have completed the setup process described in [SETUP_GUIDE.md](SETUP_GUIDE.md).

### Understanding the Architecture
Familiarize yourself with the project structure by reading [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md).

### Development Environment
- **Code Editor**: VS Code (recommended), Android Studio, or any IDE with Flutter/React support
- **Version Control**: Git
- **API Testing**: Postman, Thunder Client, or curl
- **Database GUI**: MongoDB Compass (optional)

---

## Development Workflow

### 1. Setting Up Your Branch
```bash
# Clone the repository
git clone https://github.com/Yashshukla11/Nagrik-Aur-Samvidhan.git
cd Nagrik-Aur-Samvidhan

# Create a new branch for your feature
git checkout -b feature/your-feature-name
# or for bug fixes
git checkout -b fix/bug-description
```

### 2. Development Cycle
1. Make changes in your feature branch
2. Test changes locally
3. Commit with meaningful messages
4. Push to your branch
5. Create a Pull Request

### 3. Commit Message Guidelines
Follow conventional commit format:
```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```bash
git commit -m "feat(quiz): add timer functionality to quizzes"
git commit -m "fix(auth): resolve login token expiration issue"
git commit -m "docs(readme): update setup instructions"
```

---

## Code Organization

### Flutter App Structure

```
lib/
├── Constants/          # App-wide constants
│   ├── app_controller.dart      # Global state
│   ├── Constants.dart           # String constants
│   └── Utils/                   # Utility functions
├── Services/           # Backend communication
│   ├── http_service.dart        # API calls
│   ├── secured_storage.dart     # Secure storage
│   └── connectivity_service.dart
├── UI/                 # Screens and pages
│   ├── Profile/
│   │   ├── Components/          # UI components
│   │   └── Controller/          # Business logic
│   ├── Quiz/
│   ├── ChatBot/
│   └── ...
├── Elements/           # Reusable widgets
│   └── Widgets/
├── Values/             # Design tokens
│   ├── my_color.dart
│   ├── text_styles.dart
│   └── sizes.dart
└── themes/             # Theme configuration
```

### Backend (Node.js) Structure

```
Backend/
├── controllers/        # Request handlers
│   ├── authController.js
│   ├── userController.js
│   └── quizController.js
├── models/             # Database schemas
│   ├── User.js
│   ├── Quiz.js
│   └── Progress.js
├── routes/             # API routes
│   ├── auth.js
│   ├── users.js
│   └── quiz.js
├── middlewares/        # Custom middleware
│   ├── auth.js         # Authentication
│   └── validation.js   # Input validation
├── utils/              # Helper functions
│   └── helpers.js
└── db/                 # Database configuration
    └── connection.js
```

### Web App Structure

```
src/
├── components/         # Reusable components
│   ├── Header.jsx
│   ├── Navbar.jsx
│   └── Footer.jsx
├── pages/              # Page components
│   ├── Home.jsx
│   ├── Quiz.jsx
│   └── Profile.jsx
├── login/              # Authentication
│   └── UserContext.jsx
└── App.jsx             # Main component
```

---

## Coding Standards

### Flutter (Dart)

#### Naming Conventions
```dart
// Classes: PascalCase
class UserProfile extends StatelessWidget {}

// Variables and functions: camelCase
String userName = "John";
void fetchUserData() {}

// Constants: UPPER_CASE or camelCase with const
const String API_BASE_URL = "https://api.example.com";
const int maxAttempts = 3;

// Private members: prefix with underscore
String _privateVariable;
void _privateMethod() {}
```

#### Code Style
```dart
// Use meaningful names
// Good
final userAuthToken = await storage.read(key: 'auth_token');

// Bad
final t = await storage.read(key: 'auth_token');

// Use const constructors when possible
const SizedBox(height: 16);

// Prefer final over var
final userName = "John";  // Good
var userName = "John";    // Avoid

// Use null-safety properly
String? optionalName;  // Can be null
String requiredName;   // Cannot be null

// Async/await over .then()
// Good
final data = await fetchData();

// Avoid
fetchData().then((data) => {});
```

#### Widget Building
```dart
// Extract complex widgets into separate methods or classes
class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text('Quiz'));
  }

  Widget _buildBody() {
    return ListView(children: [...]);
  }
}
```

### Backend (Node.js/Express)

#### Code Style
```javascript
// Use async/await
// Good
const getUser = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Use destructuring
const { email, password } = req.body;

// Use arrow functions for callbacks
users.map(user => user.name);

// Use template literals
const message = `Welcome ${userName}!`;

// Proper error handling
try {
  const result = await someAsyncOperation();
} catch (error) {
  logger.error('Operation failed:', error);
  throw error;
}
```

#### API Response Format
```javascript
// Success response
res.status(200).json({
  success: true,
  data: result,
  message: 'Operation successful'
});

// Error response
res.status(400).json({
  success: false,
  error: 'Error message',
  details: errorDetails
});
```

### React (Web App)

#### Component Structure
```jsx
// Functional components with hooks
import React, { useState, useEffect } from 'react';

const QuizComponent = ({ quizId }) => {
  const [quiz, setQuiz] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchQuiz();
  }, [quizId]);

  const fetchQuiz = async () => {
    try {
      const response = await axios.get(`/api/quiz/${quizId}`);
      setQuiz(response.data);
    } catch (error) {
      console.error('Failed to fetch quiz:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <LoadingSpinner />;
  
  return (
    <div className="quiz-container">
      {/* Component content */}
    </div>
  );
};

export default QuizComponent;
```

#### Naming Conventions
```jsx
// Components: PascalCase
const UserProfile = () => {};

// Functions: camelCase
const handleSubmit = () => {};

// Constants: UPPER_CASE
const API_BASE_URL = 'https://api.example.com';

// CSS classes: kebab-case
<div className="user-profile-container">
```

### Python (AI Services)

#### Code Style
```python
# Follow PEP 8
# Use snake_case for variables and functions
def fetch_constitutional_content(article_id):
    pass

# Use PascalCase for classes
class ChatbotService:
    pass

# Type hints
def process_query(query: str, user_id: int) -> dict:
    pass

# Docstrings
def simplify_content(content: str) -> str:
    """
    Simplifies constitutional content using AI.
    
    Args:
        content (str): The original content to simplify
        
    Returns:
        str: Simplified content
    """
    pass
```

---

## Testing

### Flutter Testing

#### Unit Tests
```dart
// test/services/http_service_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HttpService', () {
    test('should fetch user data successfully', () async {
      // Arrange
      final service = HttpService();
      
      // Act
      final result = await service.getUser(userId: '123');
      
      // Assert
      expect(result, isNotNull);
      expect(result.id, equals('123'));
    });
  });
}
```

#### Widget Tests
```dart
testWidgets('Quiz displays question correctly', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  expect(find.text('Quiz Question'), findsOneWidget);
  
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();
  
  expect(find.text('Correct!'), findsOneWidget);
});
```

### Backend Testing

#### Using Jest (Node.js)
```javascript
// tests/controllers/auth.test.js
describe('Auth Controller', () => {
  test('should register new user', async () => {
    const userData = {
      email: 'test@example.com',
      password: 'password123'
    };
    
    const response = await request(app)
      .post('/api/auth/register')
      .send(userData);
    
    expect(response.status).toBe(201);
    expect(response.body.success).toBe(true);
  });
});
```

### React Testing

#### Using React Testing Library
```jsx
import { render, screen, fireEvent } from '@testing-library/react';
import QuizComponent from './QuizComponent';

test('renders quiz question', () => {
  render(<QuizComponent quizId="1" />);
  const questionElement = screen.getByText(/Question 1/i);
  expect(questionElement).toBeInTheDocument();
});

test('handles answer selection', () => {
  render(<QuizComponent quizId="1" />);
  const answerButton = screen.getByRole('button', { name: /Option A/i });
  fireEvent.click(answerButton);
  expect(screen.getByText(/Correct!/i)).toBeInTheDocument();
});
```

---

## API Integration

### Making API Calls in Flutter

```dart
// lib/Services/http_service.dart
class HttpService {
  final Dio _dio = Dio();
  final String baseUrl = AppUrls.baseUrl;

  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get('$baseUrl$endpoint');
      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl$endpoint', data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
```

### Making API Calls in React

```jsx
// src/services/api.js
import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_URL;

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add auth token to requests
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('authToken');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export const fetchQuizzes = async () => {
  const response = await api.get('/quiz');
  return response.data;
};

export default api;
```

---

## State Management

### Flutter (GetX)

```dart
// lib/UI/Quiz/Controller/quiz_controller.dart
import 'package:get/get.dart';

class QuizController extends GetxController {
  // Observable variables
  var currentQuestion = 0.obs;
  var score = 0.obs;
  var isLoading = false.obs;

  // Methods
  void nextQuestion() {
    currentQuestion.value++;
  }

  void incrementScore() {
    score.value++;
  }

  Future<void> loadQuiz() async {
    isLoading.value = true;
    try {
      // Load quiz data
    } finally {
      isLoading.value = false;
    }
  }
}

// Usage in widget
class QuizScreen extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('Score: ${controller.score.value}'));
  }
}
```

### React (Context API)

```jsx
// src/context/UserContext.jsx
import React, { createContext, useState, useContext } from 'react';

const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  const login = (userData) => {
    setUser(userData);
    setIsAuthenticated(true);
  };

  const logout = () => {
    setUser(null);
    setIsAuthenticated(false);
  };

  return (
    <UserContext.Provider value={{ user, isAuthenticated, login, logout }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = () => useContext(UserContext);

// Usage
import { useUser } from './context/UserContext';

const ProfilePage = () => {
  const { user, logout } = useUser();
  
  return (
    <div>
      <h1>Welcome, {user.name}</h1>
      <button onClick={logout}>Logout</button>
    </div>
  );
};
```

---

## Best Practices

### Security

1. **Never commit sensitive data**
   - Use `.env` files for secrets
   - Add `.env` to `.gitignore`
   - Use environment variables

2. **Input validation**
   ```javascript
   // Backend validation
   const validateEmail = (email) => {
     const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
     return re.test(email);
   };
   ```

3. **Authentication**
   ```dart
   // Store tokens securely
   final storage = FlutterSecureStorage();
   await storage.write(key: 'auth_token', value: token);
   ```

### Performance

1. **Optimize images**
   - Use appropriate image sizes
   - Implement lazy loading
   - Cache network images

2. **Minimize API calls**
   - Implement pagination
   - Use local caching
   - Debounce search inputs

3. **Code splitting (React)**
   ```jsx
   import React, { lazy, Suspense } from 'react';
   
   const QuizPage = lazy(() => import('./pages/Quiz'));
   
   <Suspense fallback={<Loading />}>
     <QuizPage />
   </Suspense>
   ```

### Code Quality

1. **DRY (Don't Repeat Yourself)**
   - Extract common functionality
   - Create reusable components
   - Use utility functions

2. **Single Responsibility**
   - Each function/class should do one thing
   - Keep components focused

3. **Error Handling**
   ```dart
   try {
     final result = await apiCall();
     return result;
   } catch (e) {
     logger.error('API call failed', error: e);
     showErrorToast('Something went wrong');
     return null;
   }
   ```

---

## Common Development Tasks

### Adding a New Feature to Flutter App

1. **Create Controller**
   ```dart
   // lib/UI/NewFeature/Controller/new_feature_controller.dart
   class NewFeatureController extends GetxController {
     // Add state and logic
   }
   ```

2. **Create UI Components**
   ```dart
   // lib/UI/NewFeature/Components/new_feature_screen.dart
   class NewFeatureScreen extends StatelessWidget {
     // Build UI
   }
   ```

3. **Add Route**
   ```dart
   // lib/Constants/app_routes.dart
   static const newFeature = '/new-feature';
   ```

4. **Register Route**
   ```dart
   GetPage(name: Routes.newFeature, page: () => NewFeatureScreen())
   ```

### Adding a New API Endpoint

1. **Create Model**
   ```javascript
   // Backend/models/NewModel.js
   const mongoose = require('mongoose');
   
   const newSchema = new mongoose.Schema({
     field1: String,
     field2: Number
   });
   
   module.exports = mongoose.model('NewModel', newSchema);
   ```

2. **Create Controller**
   ```javascript
   // Backend/controllers/newController.js
   exports.create = async (req, res) => {
     // Implementation
   };
   ```

3. **Create Route**
   ```javascript
   // Backend/routes/new.js
   router.post('/', auth, newController.create);
   ```

4. **Register Route**
   ```javascript
   // Backend/app.js
   app.use('/api/new', require('./routes/new'));
   ```

### Adding a New Page to Web App

1. **Create Page Component**
   ```jsx
   // src/pages/NewPage.jsx
   const NewPage = () => {
     return <div>New Page Content</div>;
   };
   export default NewPage;
   ```

2. **Add Route**
   ```jsx
   // src/App.jsx
   import NewPage from './pages/NewPage';
   
   <Route path="/new-page" element={<NewPage />} />
   ```

3. **Add Navigation Link**
   ```jsx
   // src/components/Navbar.jsx
   <Link to="/new-page">New Page</Link>
   ```

---

## Contributing Guidelines

### Before Submitting a PR

1. **Code Quality**
   - [ ] Code follows project style guidelines
   - [ ] No console.log statements (use logger)
   - [ ] No commented-out code
   - [ ] Meaningful variable names

2. **Testing**
   - [ ] All tests pass
   - [ ] New features have tests
   - [ ] Manual testing completed

3. **Documentation**
   - [ ] Code is well-commented where needed
   - [ ] README updated if necessary
   - [ ] API documentation updated

4. **Git**
   - [ ] Meaningful commit messages
   - [ ] Branch is up to date with main
   - [ ] No merge conflicts

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How has this been tested?

## Screenshots (if applicable)
Add screenshots here

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Tests pass
- [ ] Documentation updated
```

---

## Resources

### Official Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [React Documentation](https://react.dev/)
- [Express.js Guide](https://expressjs.com/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [MongoDB Manual](https://docs.mongodb.com/manual/)

### Learning Resources
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [JavaScript MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [Python Official Tutorial](https://docs.python.org/3/tutorial/)

### Tools
- [Postman](https://www.postman.com/) - API testing
- [MongoDB Compass](https://www.mongodb.com/products/compass) - Database GUI
- [VS Code Extensions](https://code.visualstudio.com/docs/editor/extension-marketplace)
  - Flutter
  - ESLint
  - Prettier
  - Python

---

## Getting Help

- Review [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for architecture questions
- Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for setup issues
- Read [API_DOCUMENTATION.md](API_DOCUMENTATION.md) for API details
- Create an issue on GitHub for bugs or feature requests

Happy Coding! 🚀
