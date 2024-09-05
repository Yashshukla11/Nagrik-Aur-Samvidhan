import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Components/widgets/ContitutionQueryBot_tile.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Components/widgets/GenralQueryBot_Tile.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Controller/chatBotController.dart';

import '../../../Values/values.dart';

class Chatbot extends StatelessWidget {
  Chatbot({Key? key}) : super(key: key) {
    // Initialize the controller
    _logic = Get.put(ChatbotController());
  }

  late final ChatbotController _logic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyString.ChatBotheading.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstitutionQueryBot(logic: _logic),
            GenralQueryBot(logic: _logic),
          ],
        ),
      ),
    );
  }
}
