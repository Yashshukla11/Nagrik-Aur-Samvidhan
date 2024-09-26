import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Values/values.dart';

import '../controller/PlayQuizController.dart';

class PlayQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlayQuizController controller = Get.put(PlayQuizController());

    return WillPopScope(
        onWillPop: () => _onWillPop(context, controller),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => _onWillPop(context, controller),
            ),
            title: Obx(() => Text(
                  controller.quizTitle.value,
                  style: const TextStyle(
                    color: MyColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            backgroundColor: Colors.pink,
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.questions.isEmpty) {
              return Center(child: Text('No questions available'));
            } else {
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Progress indicator
                    LinearProgressIndicator(
                      value: (controller.currentQuestionIndex.value + 1) /
                          controller.questions.length,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(height: 20),
                    // Question number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${controller.currentQuestionIndex.value + 1} of ${controller.questions.length}',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        GestureDetector(
                          onTap: controller.currentQuestionIndex.value <
                                  controller.questions.length - 1
                              ? () => controller.nextQuestion()
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_forward, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    // Question Title
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          controller
                              .questions[controller.currentQuestionIndex.value]
                              .question,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Question Options
                    Expanded(
                      child: GetBuilder<PlayQuizController>(
                        builder: (controller) {
                          final question = controller
                              .questions[controller.currentQuestionIndex.value];
                          return ListView.builder(
                            itemCount: question.options.length,
                            itemBuilder: (context, index) {
                              return Obx(() {
                                final isSelected =
                                    controller.selectedAnswer.value == index;
                                final isSubmitted = question.isSubmitted.value;
                                final isThisOptionCorrect =
                                    question.options[index] ==
                                        question.correctAnswer.value;
                                final canSelectAnswer = !isSubmitted &&
                                    !controller.hasMovedToNextQuestion.value;

                                Color cardColor = Colors.white;
                                Color textColor = Colors.black;
                                Color radioColor = Colors.grey;

                                if (isSubmitted) {
                                  if (isThisOptionCorrect) {
                                    cardColor = Colors.green[100]!;
                                    textColor = Colors.green[800]!;
                                    radioColor = Colors.green;
                                  } else if (isSelected) {
                                    cardColor = Colors.red[100]!;
                                    textColor = Colors.red[800]!;
                                    radioColor = Colors.red;
                                  }
                                } else if (isSelected) {
                                  cardColor = Colors.blue.withOpacity(0.1);
                                  radioColor = Colors.blue;
                                }

                                return Card(
                                  elevation: 0,
                                  margin: EdgeInsets.only(bottom: 10),
                                  color: cardColor,
                                  child: ListTile(
                                    title: Text(
                                      question.options[index],
                                      style: TextStyle(color: textColor),
                                    ),
                                    leading: Radio<int>(
                                      value: index,
                                      groupValue:
                                          controller.selectedAnswer.value,
                                      onChanged: canSelectAnswer
                                          ? (value) {
                                              controller.selectAnswer(value!);
                                            }
                                          : null,
                                      activeColor: radioColor,
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return radioColor;
                                        }
                                        return Colors.grey;
                                      }),
                                    ),
                                    onTap: canSelectAnswer
                                        ? () {
                                            controller.selectAnswer(index);
                                          }
                                        : null,
                                  ),
                                );
                              });
                            },
                          );
                        },
                      ),
                    ),

                    // Hint Section
                    if (!controller.lastQuestionAnswered.value)
                      Obx(() {
                        final currentQuestion = controller
                            .questions[controller.currentQuestionIndex.value];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => controller.getHint(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.lightbulb_outline,
                                          color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(
                                        'Get Hint',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    // Navigation and Submit Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Obx(() {
                        if (controller.lastQuestionAnswered.value) {
                          return Center(
                              child: GestureDetector(
                            onTap: controller.isSubmitting.value
                                ? null
                                : () => controller.submitQuiz(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                color: controller.isSubmitting.value
                                    ? Colors.grey
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    controller.isSubmitting.value
                                        ? "Submitting..."
                                        : "Submit Quiz",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ));
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: controller.quizSubmitted.value ||
                                        controller.currentQuestionIndex.value <=
                                            0 ||
                                        controller
                                            .questions[controller
                                                    .currentQuestionIndex
                                                    .value -
                                                1]
                                            .isSubmitted
                                            .value
                                    ? null
                                    : () => controller.previousQuestion(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: controller.quizSubmitted.value ||
                                            controller.currentQuestionIndex
                                                    .value <=
                                                0 ||
                                            controller
                                                .questions[controller
                                                        .currentQuestionIndex
                                                        .value -
                                                    1]
                                                .isSubmitted
                                                .value
                                        ? Colors.grey
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(
                                        "Previous",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: controller.selectedAnswer.value != -1
                                    ? (controller.answerSubmitted.value
                                        ? () =>
                                            controller.continueToNextQuestion()
                                        : () => controller.submitAnswer())
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: controller.selectedAnswer.value != -1
                                        ? Colors.green
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    controller.answerSubmitted.value
                                        ? "Continue"
                                        : "Submit Answer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      }),
                    ),
                  ],
                ),
              );
            }
          }),
        ));
  }
}

Future<bool> _onWillPop(
    BuildContext context, PlayQuizController controller) async {
  final shouldPop = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Exit Quiz?'),
        content: Text(
            'Are you sure you want to exit? Your progress will be submitted.'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () async {
              await controller.submitQuiz();
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
  return shouldPop ?? false;
}

class HintPopup extends StatelessWidget {
  final String hint;

  const HintPopup({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hint',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(),
            SizedBox(height: 16),
            Text(
              hint,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColor.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Got it!',
                  style: TextStyle(fontSize: 18, color: MyColor.darkBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
