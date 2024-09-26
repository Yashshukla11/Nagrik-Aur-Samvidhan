import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Quiz/Components/widgets/MainQuiz.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Quiz/Components/widgets/case_studies.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Quiz/Controller/QuizScreenController.dart';

import '../../Home/Component/widget/daily_quiz.dart';
import '../../Home/Controller/home_controller.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  final _logic1 = Get.put(HomeController());
  final _logic = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFDDEFBB),
              Color(0xFFFFEEEE),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Quiz Catalogue',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    DailyQuizTile(logic: _logic1),
                    SizedBox(height: 20),
                    Quiz(logic: _logic),
                    SizedBox(height: 20),
                    CaseStudyTile(logic: _logic),
                    SizedBox(height: 20),
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
