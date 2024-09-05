import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Components/widgets/ChatbotScreen.dart';
import '../../../Values/values.dart';

class ChatbotController extends GetxController {
  late PageController pageController;
  RxString ChatBotsubTitle = MyString.ChatBotsubTitle.tr.obs;

  Future<void> onChatbotTapConstitutionalBot() async {
    Get.to(
          () => Chatbot_Screen(),
      arguments: {"type": "ConstitutionalBot"},
    );
  }

  Future<void> onChatbotTapGeneralBot() async {
    Get.to(
          () => Chatbot_Screen(),
      arguments: {"type": "GeneralBot"},
    );
  }
}