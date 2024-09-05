import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Quiz/Components/widgets/MainQuiz.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Quiz/Components/widgets/case_studies.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Quiz/Controller/QuizScreenController.dart';

import '../../../Values/values.dart';
import '../../Home/Component/widget/daily_quiz.dart';
import '../../Home/Controller/home_controller.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  final _logic1 = Get.put(HomeController());
  final _logic = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyString.Quiz.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DailyQuizTile(logic: _logic1),
            SizedBox(height: 20),
            Quiz(logic: _logic),
            SizedBox(height: 20),
            CaseStudyTile(logic: _logic),
          ],
        ),
      ),
    );
  }
}
