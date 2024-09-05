import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Components/widgets/ChatbotScreen.dart';

import '../../../Routing/routes.dart';
import '../../../Values/values.dart';
import 'chatbotScreenController.dart';

class ChatbotController extends GetxController {
  late PageController pageController;
  RxString ChatBotsubTitle = MyString.ChatBotsubTitle.tr.obs;

  Future<void> onChatbotTap() async {
    Get.to(
      Chatbot_Screen(),
      arguments: [],
    );
  }
}
