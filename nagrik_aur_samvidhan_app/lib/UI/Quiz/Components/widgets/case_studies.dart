import 'package:cached_network_image/cached_network_image.dart'; // Import the package
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Values/values.dart';
import '../../Controller/QuizScreenController.dart';

class CaseStudyTile extends StatelessWidget {
  final QuizController logic;

  const CaseStudyTile({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: logic.onCaseStudyTap,
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
                  // Use CachedNetworkImageProvider for background
                  'https://i.postimg.cc/yd9v5vLM/case1.jpg', // Replace the URL with your image URL
                ),
                fit: BoxFit.fitWidth,
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
                        MyString.caseStudy.tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: MyColor.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 46),
                    Text(
                      logic.caseStudysubtitle.value,
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
