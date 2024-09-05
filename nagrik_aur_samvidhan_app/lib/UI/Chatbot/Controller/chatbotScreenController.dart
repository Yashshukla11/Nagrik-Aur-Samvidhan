import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nagrik_aur_samvidhan_app/Constants/Constants.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';
import 'package:nagrik_aur_samvidhan_app/Values/values.dart';

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

  Future<void> sendMessage(String message) async {
    isLoading.value = true;
    messages.add(message);

    try {
      String endpoint = type.value == 'ConstitutionalBot'
          ? '${AppUrls.chatBotUrl}/get_legal?user_prompt=$message'
          : '${AppUrls.chatBotUrl}/get_educational?user_prompt=$message';

      final response = await http.post(Uri.parse(endpoint));

      Debug.setLog('-----------------> $endpoint');
      Debug.setLog('-----------------> ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        String answer = jsonResponse['answer'];
        messages.add('answer: $answer');
      } else {
        messages.add("answer: Sorry, I couldn't process your request. Please try again.");
      }
    } catch (e) {
      messages.add("answer: An error occurred. Please try again later.");
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearMessages() async {
    messages.clear();
  }
}