import 'package:cached_network_image/cached_network_image.dart'; // Import the package
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Values/values.dart';
import '../../Controller/QuizScreenController.dart';

class Quiz extends StatelessWidget {
  final QuizController logic;

  const Quiz({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: logic.onMainQuizTap,
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
                image: CachedNetworkImageProvider(
                  'https://i.postimg.cc/L8xxcq2V/jez-timms-8mu-UTAmc-WU4-unsplash.jpg',
                ),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Sizes.WIDTH_200,
                      height: Sizes.HEIGHT_75,
                      child: Text(
                        MyString.Quiz.tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: MyColor.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: Sizes.WIDTH_250,
                      height: Sizes.HEIGHT_40,
                      child: Text(
                        logic.mainQuizsubtitle.value,
                        style: TextStyle(
                          color: MyColor.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: MyColor.white,
                ),
              ],
            ),
          ),
        ));
  }
}
