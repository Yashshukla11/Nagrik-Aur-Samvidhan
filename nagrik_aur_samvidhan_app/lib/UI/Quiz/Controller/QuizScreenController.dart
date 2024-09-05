import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Timeline/Components/Timeline.dart';

import '../../../Routing/routes.dart';
import '../../../Values/values.dart';

class QuizController extends GetxController {
  RxString caseStudysubtitle = MyString.caseStudysubTitle.tr.obs;
  RxString mainQuizsubtitle = MyString.mainQuizsubTitle.tr.obs;

  void onCaseStudyTap() {
    print('CaseStudyTap');
  }

  void onMainQuizTap() {
    Get.to(Timeline());
  }
}
