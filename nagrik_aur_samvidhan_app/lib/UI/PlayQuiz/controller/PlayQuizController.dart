import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/Constants.dart';
import '../../../Services/http_service.dart';
import '../components/PlayQuiz.dart';

class Question {
  final String id;
  final String question;
  final List<String> options;
  RxString correctAnswer = RxString('');
  RxBool isAnswerCorrect = RxBool(false);

  RxString hint = RxString('');
  RxBool hintTaken = RxBool(false);
  RxBool isSubmitted = RxBool(false);

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
  final RxInt selectedAnswer = RxInt(-1);
  var quizTitle = ''.obs;
  var attemptId = ''.obs;
  var isSubmitting = false.obs;
  var quizSubmitted = false.obs;
  var lastQuestionAnswered = false.obs;
  var isCaseStudy = false.obs;
  var quizId = ''.obs;
  final HttpService _httpService = Get.find<HttpService>();
  var answerSubmitted = false.obs;
  var hasMovedToNextQuestion = false.obs;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    quizId.value = args['quizId'];
    isCaseStudy.value = args['type'] == 'CaseStudy';
    Debug.setLog('Quiz/CaseStudy ID: ${quizId.value}');

    fetchQuizData();
  }

  Future<void> fetchQuizData() async {
    isLoading(true);
    try {
      final String endpoint = isCaseStudy.value
          ? '/casestudy/start/${quizId.value}'
          : '/quiz/start/${quizId.value}';
      final data = await _httpService.authenticatedRequest(endpoint);
      Debug.setLog('Quiz/CaseStudy data: $data');

      quizTitle.value = data['title'];
      attemptId.value = data['attemptId'];
      questions.value =
          (data['questions'] as List).map((q) => Question.fromJson(q)).toList();
    } catch (e) {
      print('Error fetching quiz/casestudy data: $e');
      Get.snackbar('Error', 'Failed to load quiz/casestudy data');
    } finally {
      isLoading(false);
    }
  }

  void selectAnswer(int index) {
    if (!hasMovedToNextQuestion.value) {
      selectedAnswer.value = index;
    }
  }

  Future<void> submitAnswer() async {
    if (selectedAnswer.value == -1) {
      // No answer selected, prevent submission
      return;
    }

    try {
      final String endpoint = isCaseStudy.value
          ? '/casestudy/submitquestion/${attemptId.value}'
          : '/quiz/submitquestion/${attemptId.value}';
      final response = await _httpService.authenticatedRequest(
        endpoint,
        method: 'POST',
        data: {
          "questionId": questions[currentQuestionIndex.value].id,
          "answer": questions[currentQuestionIndex.value]
              .options[selectedAnswer.value]
        },
      );

      if (response['message'] != "Attempt already submitted") {
        // Mark the current question as submitted
        questions[currentQuestionIndex.value].isSubmitted.value = true;
        answerSubmitted.value = true;

        // Update correct answer and whether the user's answer was correct
        if (response['result'] != null) {
          questions[currentQuestionIndex.value].correctAnswer.value =
              response['result']['correctAnswer'];
          questions[currentQuestionIndex.value].isAnswerCorrect.value =
              response['result']['isCorrect'];
        }
      }
    } catch (e) {
      print('Error submitting answer: $e');
    }
  }

  void continueToNextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      nextQuestion();
      answerSubmitted.value = false;
      hasMovedToNextQuestion.value = true;
    } else {
      lastQuestionAnswered.value = true;
    }
  }

  Future<void> getHint() async {
    try {
      final String endpoint = isCaseStudy.value
          ? '/casestudy/hint/${attemptId.value}'
          : '/quiz/hint/${attemptId.value}';
      final response = await _httpService.authenticatedRequest(
        endpoint,
        method: 'GET',
        data: {"questionId": questions[currentQuestionIndex.value].id},
      );

      if (response['message'] == "Hint already taken" ||
          response['hint'] != null) {
        questions[currentQuestionIndex.value].hint.value = response['hint'];
        questions[currentQuestionIndex.value].hintTaken.value = true;

        Get.dialog(
          HintPopup(hint: response['hint']),
          barrierDismissible: false,
          transitionDuration: Duration(milliseconds: 300),
          transitionCurve: Curves.easeInOut,
        );
      } else {
        Get.snackbar('Error', 'Failed to get hint');
      }
    } catch (e) {
      print('Error getting hint: $e');
      Get.snackbar('Error', 'Failed to get hint');
    }
  }

  Future<void> submitQuiz() async {
    isSubmitting(true);
    try {
      final String endpoint = isCaseStudy.value
          ? '/casestudy/submit/${attemptId.value}'
          : '/quiz/submit/${attemptId.value}';
      final response = await _httpService.authenticatedRequest(
        endpoint,
        method: 'GET',
      );

      if (response['message'] == "Attempt already submitted") {
        quizSubmitted.value = true;
        Get.snackbar('Info', 'This quiz/casestudy has already been submitted');
      } else {
        quizSubmitted.value = true;
        Get.snackbar('Success', 'Quiz/CaseStudy submitted successfully');

        // For CaseStudy, show the result
        if (isCaseStudy.value) {
          Get.dialog(
            AlertDialog(
              title: Text('CaseStudy Result'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Correct Answers: ${response['numberOfCorrectAnswers']}'),
                  Text('Score: ${response['score']}'),
                  Text('Total Questions: ${response['totalQuestions']}'),
                  Text('Percentage: ${response['percentage']}%'),
                  Text('Passed: ${response['isPassed'] ? 'Yes' : 'No'}'),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      print('Error submitting quiz/casestudy: $e');
      Get.snackbar('Error', 'Failed to submit quiz/casestudy');
    } finally {
      isSubmitting(false);
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswer.value = -1;
      hasMovedToNextQuestion.value = true;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex--;
      selectedAnswer.value = -1;
      hasMovedToNextQuestion.value = false;
    }
  }
}
