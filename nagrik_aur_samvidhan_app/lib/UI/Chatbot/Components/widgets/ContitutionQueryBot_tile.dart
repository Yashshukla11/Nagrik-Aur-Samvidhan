import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Elements/Widgets/spaces.dart';

import '../../../../Values/values.dart';
import '../../Controller/chatBotController.dart';

class ConstitutionQueryBot extends StatelessWidget {
  final ChatbotController logic;

  const ConstitutionQueryBot({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: logic.onChatbotTapConstitutionalBot,
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
                    'https://i.postimg.cc/RVzW53Jt/chatbot.jpg'),
                fit: BoxFit.fitWidth,
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
                        MyString.ChatBotLegal.tr,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            color: MyColor.white),
                      ),
                    ),
                    SizedBox(height: 46),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          logic.ChatBotsubTitle.value,
                          style: TextStyle(color: MyColor.white),
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
                            color: MyColor.white,
                          ),
                        )
                      ],
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
