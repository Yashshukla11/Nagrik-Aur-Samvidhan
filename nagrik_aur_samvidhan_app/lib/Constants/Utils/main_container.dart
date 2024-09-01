import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/About/Components/About.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Chatbot/Components/chatbot.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Profile/Components/Profile.dart';

import '../../UI/Base/Component/bottom_nav.dart';
import '../../UI/Base/Controller/bottom_nav_controller.dart';
import '../../UI/Home/Component/home_screen.dart';
import '../../UI/Quiz/Components/Quiz.dart';

class MainContainer extends StatelessWidget {
  final BottomNavController _navController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (_navController.selectedIndex.value) {
          case 0:
            return HomeScreen();
          case 1:
            return QuizScreen();
          case 2:
            return ChatBot();
          case 3:
            return ProfileScreen();
          default:
            return HomeScreen();
        }
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BottomNav(),
      ),
    );
  }
}
