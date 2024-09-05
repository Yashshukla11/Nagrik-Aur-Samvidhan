import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nagrik_aur_samvidhan_app/Constants/Constants.dart';
import 'dart:convert';
import '../../../Services/http_service.dart';

import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';

class CaseStudy {
  final String id;
  final String title;
  final int duration;
  final int totalQuestions;
  final String description;
  final String difficulty;
  final bool isPassed;
  final bool isAttempted;
  final int score;
  final String percentage;
  final String type;

  CaseStudy({
    required this.id,
    required this.title,
    required this.duration,
    required this.totalQuestions,
    required this.description,
    required this.difficulty,
    this.isPassed = false,
    this.isAttempted = false,
    this.score = 0,
    this.percentage = "0",
    required this.type,
  });

  factory CaseStudy.fromJson(Map<String, dynamic> json) {
    return CaseStudy(
      id: json['_id'],
      title: json['title'],
      duration: json['duration'],
      totalQuestions: json['totalQuestions'],
      description: json["description"] ?? "",
      difficulty: json['difficulty'],
      isPassed: json['isPassed'] ?? false,
      isAttempted: json['isAttempted'] ?? false,
      score: json['score'] ?? 0,
      percentage: json['percentage'] ?? "0",
      type: json['type'],
    );
  }
}

class CaseStudyController extends GetxController {
  var caseStudies = <CaseStudy>[].obs;
  var isLoading = true.obs;
  final HttpService _httpService = Get.find<HttpService>();

  String title = "";

  // @override
  // void onInit() {
  //   getArguments();
  //   super.onInit();
  //   fetchCaseStudies();
  // }

  @override
  void onReady() {
    getArguments();
    super.onReady();
    fetchCaseStudies();
  }

  Future<void> getArguments() async {
    title = Get.arguments['title'];
    Debug.setLog('Title: $title');
  }

  void fetchCaseStudies() async {
    isLoading(true);
    final response =
        await _httpService.authenticatedRequestGeneral('/map/${title}');
    Debug.setLog('Case Studies response: $response');

    try {
      // Assuming the case studies are stored directly in the response list
      caseStudies.value = response
          .map((caseStudyJson) => CaseStudy.fromJson(caseStudyJson))
          .toList();
    } catch (e) {
      print('Error fetching case studies: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
