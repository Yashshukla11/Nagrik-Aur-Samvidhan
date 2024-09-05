import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nagrik_aur_samvidhan_app/Constants/Constants.dart';
import 'dart:convert';
import '../../../Services/http_service.dart';

import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';

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
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['_id'],
      title: json['title'],
      duration: json['duration'],
      totalQuestions: json['totalQuestions'],
      difficulty: json['difficulty'],
      isPassed: json['isPassed'] ?? false,
      isAttempted: json['isAttempted'] ?? false,
      score: json['score'] ?? 0,
      percentage: json['percentage'] ?? "0",
      type: json['type'],
    );
  }
}

class QuizzesController extends GetxController {
  var quizzes = <Quiz>[].obs;
  var isLoading = true.obs;
  final HttpService _httpService = Get.find<HttpService>();

  String title = "";

  // @override
  // void onInit() {
  //   super.onInit();
  //   getArguments();
  //   fetchQuizzes();
  // }

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
    final response =
        await _httpService.authenticatedRequestGeneral('/map/$title');
    Debug.setLog('Quizzes response: $response');

    try {
      // Assuming the quizzes are stored directly in the response list
      quizzes.value =
          response.map((quizJson) => Quiz.fromJson(quizJson)).toList();
    } catch (e) {
      print('Error fetching quizzes: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
