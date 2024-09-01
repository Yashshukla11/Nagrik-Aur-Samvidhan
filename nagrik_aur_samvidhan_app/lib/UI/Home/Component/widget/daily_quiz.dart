import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/home_controller.dart';
import '../../../../Values/values.dart';

class DailyQuizTile extends StatelessWidget {
  final HomeController logic;

  const DailyQuizTile({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: logic.onDailyQuizTap,
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/home/test2.jpg'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      MyString.DailyQuiz,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: MyColor.black),
                    ),
                    SizedBox(height: 46),
                    Text(
                      logic.quizSubtitle.value,
                      style: TextStyle(color: MyColor.white),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ));
  }
}
