import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../Constants/Constants.dart';
import '../../../Constants/Utils/app_urls.dart';
import '../../../Services/http_service.dart';
import '../Components/widgets/improved_tts.dart';

class ChatbotScreenController extends GetxController {
  var messages = <String>[].obs;
  var isLoading = false.obs;
  RxString type = ''.obs;
  RxString currentLanguage = 'kn-IN'.obs;
  late ImprovedTTS tts;
  final HttpService _httpService = Get.find<HttpService>();

  @override
  void onInit() {
    super.onInit();
    tts = ImprovedTTS();

    Debug.setLog("ChatbotScreenController onInit started");
    initializeController();
  }

  Future<void> initializeController() async {
    Debug.setLog("Initializing ChatbotScreenController");
    try {
      await fetchCurrentLanguage();
      tts = ImprovedTTS();
      tts.setLanguage(currentLanguage.value);
      await getArgument();
      Debug.setLog("ChatbotScreenController initialization completed");
    } catch (e) {
      Debug.setLog("Error during ChatbotScreenController initialization: $e");
    }
  }

  Future<void> getArgument() async {
    Debug.setLog("Getting arguments");
    type.value = Get.arguments['type'];
    Debug.setLog("-----------------> ${type.value}");
  }

  Future<void> fetchCurrentLanguage() async {
    Debug.setLog("Fetching current language");
    try {
      final response = await _httpService.authenticatedRequest('/user/get');
      _updateLanguage(response['language']);
      Debug.setLog('-----------11------> ${currentLanguage.value}');
    } catch (e) {
      Debug.setLog('Exception occurred while fetching language: $e');
    }
  }

  void _updateLanguage(String language) {
    currentLanguage.value = language;
    tts.setLanguage(language);
    Debug.setLog('Language updated to: $language');
  }

  Future<void> sendMessage(String message) async {
    isLoading.value = true;
    messages.add(message);

    try {
      Debug.setLog(
          'Current language when sending message: ${currentLanguage.value}');

      String endpoint = type.value == 'ConstitutionalBot'
          ? '${AppUrls.chatBotUrl}/get_educational?user_prompt=$message&language=${currentLanguage.value}'
          : '${AppUrls.chatBotUrl}/get_legal?user_prompt=$message&language=${currentLanguage.value}';

      final response = await http.post(Uri.parse(endpoint));

      Debug.setLog('-----------------> $endpoint');
      Debug.setLog('-----------------> ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        String answer = jsonResponse['answer'];

        String decodedAnswer = utf8.decode(answer.runes.toList());

        messages.add('answer: $decodedAnswer');
      } else {
        messages.add(
            "answer: Sorry, I couldn't process your request. Please try again.");
        Debug.setLog('Error: Non-200 status code: ${response.statusCode}');
        Debug.setLog('Response body: ${response.body}');
      }
    } catch (e) {
      messages.add("answer: An error occurred. Please try again later.");
      if (kDebugMode) {
        print("Error: $e");
      }
      Debug.setLog('Exception occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearMessages() async {
    messages.clear();
  }

  void setLanguage(String languageCode) {
    _updateLanguage(languageCode);
  }

  Future<void> speakMessage(String message) async {
    await tts.speak(message, currentLanguage.value);
  }
}
