import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Constants/Constants.dart';
import '../../../Services/http_service.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';

import '../../PlayQuiz/components/PlayQuiz.dart';

class Quiz {
  final String id;
  final String title;
  final int duration;
  final int totalQuestions;
  final String difficulty;
  final bool isPassed;
  final bool isAttempted;
  final int score;
  final String percentage;
  final String type;
  final String? description;

  Quiz({
    required this.id,
    required this.title,
    required this.duration,
    required this.totalQuestions,
    required this.difficulty,
    this.isPassed = false,
    this.isAttempted = false,
    this.score = 0,
    this.percentage = "0",
    required this.type,
    this.description,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['_id'].toString(),
      title: json['title'].toString(),
      duration: json['duration'],
      totalQuestions: json['totalQuestions'],
      difficulty: json['difficulty'].toString(),
      isPassed: json['isPassed'] ?? false,
      isAttempted: json['isAttempted'] ?? false,
      score: json['score'] ?? 0,
      percentage: json['percentage']?.toString() ?? "0",
      type: json['type'].toString(),
      description: json['description']?.toString(),
    );
  }
}

class QuizzesController extends GetxController {
  var quizzes = <Quiz>[].obs;
  var isLoading = true.obs;
  final HttpService _httpService = Get.find<HttpService>();

  String title = "";

  @override
  void onReady() {
    getArguments();
    super.onReady();
    fetchQuizzes();
  }

  Future<void> getArguments() async {
    title = Get.arguments['title'];
    Debug.setLog('Title: $title');
  }

  void fetchQuizzes() async {
    isLoading(true);
    try {
      final response =
          await _httpService.authenticatedRequestGeneral('/map/$title');
      Debug.setLog('---------------Quizzes response: $response');
      quizzes.value = (response as List)
          .map<Quiz>((quizJson) => Quiz.fromJson(quizJson))
          .toList();
    } catch (e) {
      print('-----------------Error fetching quizzes: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void handleQuizTap(Quiz quiz) {
    if (quiz.isPassed) {
      Get.dialog(
        AlertDialog(
          title: Text('Quiz Already Completed'),
          content: Text(
              'You have already passed this quiz. Your score was ${quiz.score}/${quiz.totalQuestions} (${quiz.percentage}%).'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    } else {
      Get.to(() => PlayQuiz(), arguments: {'quizId': quiz.id});
    }
  }
}
