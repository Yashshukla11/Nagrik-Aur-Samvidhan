import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Home/Component/widget/carousel.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Home/Component/widget/daily_quiz.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Home/Component/widget/news.dart';
import '../Controller/home_controller.dart';
import '../../../Values/values.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key) {
    // Initialize the controller
    _logic = Get.put(HomeController());
  }

  late final HomeController _logic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyString.home),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: CarouselWidget(logic: _logic),
            ),
            SizedBox(height: 20),
            DailyQuizTile(logic: _logic),
            SizedBox(height: 20),
            NewsSection(logic: _logic),
          ],
        ),
      ),
    );
  }
}
