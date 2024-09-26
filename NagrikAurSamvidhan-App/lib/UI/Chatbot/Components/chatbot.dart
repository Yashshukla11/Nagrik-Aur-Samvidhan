import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Components/widgets/ContitutionQueryBot_tile.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Components/widgets/GenralQueryBot_Tile.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Controller/chatBotController.dart';

import '../../../Values/values.dart';

class Chatbot extends StatelessWidget {
  Chatbot({super.key}) {
    _logic = Get.put(ChatbotController());
  }

  late final ChatbotController _logic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFABBAAB),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                MyString.ChatBotheading.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ConstitutionQueryBot(logic: _logic),
                    GenralQueryBot(logic: _logic),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
