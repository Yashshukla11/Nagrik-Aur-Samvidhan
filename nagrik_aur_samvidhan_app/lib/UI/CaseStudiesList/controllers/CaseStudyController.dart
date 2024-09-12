import 'package:get/get.dart';

import '../../../Constants/Constants.dart';
import '../../../Services/http_service.dart';

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
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      description: json['description'] ?? '',
      difficulty: json['difficulty'] ?? '',
      isPassed: json['isPassed'] ?? false,
      isAttempted: json['isAttempted'] ?? false,
      score: json['score'] ?? 0,
      percentage: (json['percentage'] ?? 0).toString(),
      type: json['type'] ?? '',
    );
  }
}

class CaseStudyController extends GetxController {
  var caseStudies = <CaseStudy>[].obs;
  var isLoading = true.obs;
  final HttpService _httpService = Get.find<HttpService>();

  String title = "";

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

  Future<void> fetchCaseStudies() async {
    isLoading(true);
    try {
      final response =
          await _httpService.authenticatedRequestGeneral('/casestudy');
      Debug.setLog('Case Studies response: $response');

      if (response is List) {
        caseStudies.value = response
            .map((caseStudyJson) => CaseStudy.fromJson(caseStudyJson))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error fetching case studies: $e');
      Get.snackbar('Error', 'An error occurred while fetching case studies');
    } finally {
      isLoading(false);
    }
  }
}
