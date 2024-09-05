import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/PlayQuizController.dart';

class PlayQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlayQuizController controller = Get.put(PlayQuizController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.quizTitle.value)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.questions.isEmpty) {
          // Handle case when no questions are available
          return Center(child: Text('No questions available'));
        } else {
          return Column(
            children: [
              // Question Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  controller.questions[controller.currentQuestionIndex.value]
                      .question,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // Question Options
              Expanded(
                child: ListView.builder(
                  itemCount: controller
                      .questions[controller.currentQuestionIndex.value]
                      .options
                      .length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller
                          .questions[controller.currentQuestionIndex.value]
                          .options[index]),
                      leading: Obx(() => Radio<int>(
                        value: index,
                        groupValue: controller.selectedAnswer.value,
                        onChanged: (value) {
                          controller.selectAnswer(value!);
                        },
                      )),
                    );
                  },
                ),
              ),
              // Previous and Next buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.currentQuestionIndex.value > 0
                        ? () => controller.previousQuestion()
                        : null,
                    child: Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: controller.currentQuestionIndex.value <
                        controller.questions.length - 1
                        ? () => controller.nextQuestion()
                        : null,
                    child: Text("Next"),
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
