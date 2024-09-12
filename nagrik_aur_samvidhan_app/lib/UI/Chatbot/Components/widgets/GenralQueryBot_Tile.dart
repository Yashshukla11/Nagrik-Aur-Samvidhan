import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Elements/Widgets/spaces.dart';

import '../../../../Values/values.dart';
import '../../Controller/chatBotController.dart';

class GenralQueryBot extends StatelessWidget {
  final ChatbotController logic;

  const GenralQueryBot({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: logic.onChatbotTapGeneralBot,
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
                    'https://i.postimg.cc/HsDjbJpx/download-3.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Sizes.WIDTH_250,
                      height: Sizes.HEIGHT_75,
                      child: Text(
                        MyString.ChatBotEducational.tr,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: MyColor.black),
                      ),
                    ),
                    SizedBox(height: 46),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          logic.ChatBotsubTitle.value,
                          style: TextStyle(color: MyColor.black),
                        ),
                        SpaceW20(),
                        SizedBox(
                          height: Sizes.HEIGHT_30,
                          width: Sizes.WIDTH_30,
                          child: Image(
                            image:
                                AssetImage('assets/ChatBot/chattilelogo.png'),
                            height: Sizes.HEIGHT_30,
                            width: Sizes.WIDTH_30,
                            color: MyColor.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: MyColor.black,
                ),
              ],
            ),
          ),
        ));
  }
}
