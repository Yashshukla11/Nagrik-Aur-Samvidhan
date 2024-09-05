import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Constants.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';
import '../../../Services/secured_storage.dart'; // Add this import
import '../../../Services/http_service.dart';

class TimelineController extends GetxController {
  final Dio _dio = Dio();
  final String baseUrl =
      AppUrls.apiBaseUrl; // Replace with your actual base URL
  final SecureStorage _secureStorage = Get.find<SecureStorage>();
  final HttpService _httpService = Get.find<HttpService>();

  var timelineData = {}.obs;
  var isLoading = true.obs;
  RxString type = "".obs;

  // @override
  // void onInit() {
  //   getArguments();
  //   super.onInit();
  //   fetchTimelineData();
  // }

  @override
  void onReady() {
    getArguments();
    super.onReady();
    fetchTimelineData();
  }

  @override
  void onClose() {
    type.value = "";
    super.onClose();
  }

  Future<void> getArguments() async {
    type = Get.arguments["type"];
    Debug.setLog('type: $type');
  }

  Future<void> fetchTimelineData() async {
    isLoading(true);
    try {
      final response = await _httpService.authenticatedRequest('/map');
      timelineData.value = Map<String, dynamic>.from(response);
      Debug.setLog('Timeline data: $timelineData');
    } catch (e) {
      print('Error fetching timeline data: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  String getTitle(String level) {
    return level ?? '0';
  }

  RxString getType() {
    Debug.setLog("-------------------------> type: $type");
    return type;
  }

  String getCompletionPercentage(String level) {
    return timelineData[level]?['completionPercentage'] ?? '0';
  }

  bool isLevelLocked(String level) {
    return timelineData[level]?['isLocked'] ?? true;
  }

  int getTotalQuizCount(String level) {
    return timelineData[level]?['totalQuizCount'] ?? 0;
  }

  int getTotalCaseStudyCount(String level) {
    return timelineData[level]?['totalCaseStudyCount'] ?? 0;
  }

  int getTotalPassedCount(String level) {
    return timelineData[level]?['totalPassedCount'] ?? 0;
  }
}
