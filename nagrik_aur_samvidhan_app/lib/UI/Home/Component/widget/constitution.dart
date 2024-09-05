import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/home_controller.dart';
import '../../../../Values/values.dart';

class Constitution extends StatelessWidget {
  final HomeController logic;

  const Constitution({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: logic.onConstitutionTap,
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
                image: AssetImage('assets/home/constitution2.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFFFF9933),
                          Colors.white,
                          Color(0xFF138808)
                        ], // Indian tri-colors
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: Text(
                        logic.constitutionSubstring.value,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight
                                .w700), // The color here is a fallback color
                      ),
                    ),
                    SizedBox(height: Sizes.HEIGHT_70),
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
