import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Values/values.dart';

class ChatbotScreenController extends GetxController {
  var messages = <String>[].obs;
  var isLoading = false.obs;

  void sendMessage(String message) {
    isLoading.value = true;
    messages.add(message);

    Future.delayed(Duration(seconds: 2), () {
      messages.add("${MyString.response.tr}: $message");
      isLoading.value = false;
    });
  }
}
