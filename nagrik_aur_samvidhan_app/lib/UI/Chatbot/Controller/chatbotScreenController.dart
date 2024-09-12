import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nagrik_aur_samvidhan_app/Constants/Constants.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';

class ChatbotScreenController extends GetxController {
  var messages = <String>[].obs;
  var isLoading = false.obs;
  RxString type = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  Future<void> getArgument() async {
    type.value = Get.arguments['type'];
    Debug.setLog("-----------------> ${type.value}");
  }

  Future<void> sendMessage(String message, {String language = 'Hindi'}) async {
    isLoading.value = true;
    messages.add(message);

    try {
      String endpoint = type.value == 'ConstitutionalBot'
          ? '${AppUrls.chatBotUrl}/get_educational?user_prompt=$message&language=$language'
          : '${AppUrls.chatBotUrl}/get_legal?user_prompt=$message&language=$language';

      final response = await http.post(Uri.parse(endpoint));

      Debug.setLog('-----------------> $endpoint');
      Debug.setLog('-----------------> ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        String answer = jsonResponse['answer'];

        // Decode the UTF-8 encoded string
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
}
