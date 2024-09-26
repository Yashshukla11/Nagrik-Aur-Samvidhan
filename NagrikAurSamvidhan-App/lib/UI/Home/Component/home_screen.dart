import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Home/Component/widget/carousel.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Home/Component/widget/constitution.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Home/Component/widget/daily_quiz.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Home/Component/widget/news.dart';

import '../../../Values/values.dart';
import '../Controller/home_controller.dart';

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
        title: Text(MyString.home.tr),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEAEAEA),
              Color(0xFFDBDBDB),
              Color(0xFFF2F2F2),
              Color(0xFFADA996),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: CarouselWidget(logic: _logic),
              ),
              SizedBox(height: 20),
              Constitution(),
              SizedBox(height: 20),
              DailyQuizTile(logic: _logic),
              SizedBox(height: 10),
              NewsSection(logic: _logic),
            ],
          ),
        ),
      ),
    );
  }
}
