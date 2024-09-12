import 'package:cached_network_image/cached_network_image.dart'; // Import the package
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Values/values.dart';
import '../../Controller/home_controller.dart';

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
                image: CachedNetworkImageProvider(
                  'https://i.postimg.cc/HW0RSkc6/download-1.png',
                ),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
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
                        MyString.DailyQuiz.tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: MyColor.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 46),
                    Text(
                      logic.quizSubtitle.value,
                      style: TextStyle(
                          color: MyColor.white, fontWeight: FontWeight.w600),
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
