import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';
import '../../../Constants/Constants.dart';
import '../../../Services/http_service.dart';

class Question {
  final String id;
  final String question;
  final List<String> options;

  Question({required this.id, required this.question, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      question: json['question'],
      options: List<String>.from(json['options']),
    );
  }
}

class PlayQuizController extends GetxController {
  var isLoading = true.obs;
  var questions = <Question>[].obs;
  var currentQuestionIndex = 0.obs;
  var selectedAnswer = (-1).obs;
  var quizTitle = ''.obs;
  var attemptId = ''.obs;
  final HttpService _httpService = Get.find<HttpService>();

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    final String quizId = args['quizId'];
    Debug.setLog('Quizzes quizId: $quizId');

    fetchQuizData(quizId);
  }

  Future<void> fetchQuizData(String quizId) async {
    isLoading(true);
    try {
      // Using the authenticatedRequest method from HttpService
      final data =
      await _httpService.authenticatedRequest('/quiz/start/$quizId');
      Debug.setLog('Quizzes of id: $data');

      quizTitle.value = data['title'];
      attemptId.value = data['attemptId'];
      questions.value =
          (data['questions'] as List).map((q) => Question.fromJson(q)).toList();
    } catch (e) {
      print('Error fetching quiz data: $e');
      Get.snackbar('Error', 'Failed to load quiz data');
    } finally {
      isLoading(false);
    }
  }

  void selectAnswer(int index) {
    selectedAnswer.value = index;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswer.value = -1;
    } else {
      Get.snackbar('Quiz Completed', 'Submitting your answers...');
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex--;
      selectedAnswer.value = -1;
    }
  }
}
