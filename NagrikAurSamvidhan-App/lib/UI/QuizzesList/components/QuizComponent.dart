import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Values/values.dart';

import '../controllers/QuizController.dart';

class QuizzesComponent extends StatelessWidget {
  final QuizzesController controller = Get.put(QuizzesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
        backgroundColor: MyColor.breakInBtnColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          var quizzes =
              controller.quizzes.where((quiz) => quiz.type == 'Quiz').toList();
          if (quizzes.isEmpty) {
            return const Center(
              child: Text(
                'No Quizzes available.',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              var quiz = quizzes[index];
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF636FA4), Color(0xFFE8CBC0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      '${index + 1}. ${quiz.title}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Total Questions: ${quiz.totalQuestions}'),
                        if (quiz.description != null)
                          Text('Description: ${quiz.description}'),
                      ],
                    ),
                    onTap: () => controller.handleQuizTap(quiz),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
