import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Constants.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Timeline/Components/Timeline.dart';

import '../../../Values/values.dart';
import '../../CaseStudiesList/components/CaseStudyComponent.dart';

class QuizController extends GetxController {
  RxString caseStudysubtitle = MyString.caseStudysubTitle.tr.obs;
  RxString mainQuizsubtitle = MyString.mainQuizsubTitle.tr.obs;
  RxString Quiz = 'Quiz'.obs;
  RxString CaseStudy = 'CaseStudy'.obs;

  void onCaseStudyTap() {
    Debug.setLog("Navigating to Timeline with CaseStudy type");
    Get.to(() => CaseStudyComponent(), arguments: {"title": CaseStudy.value});
    Debug.setLog("Arguments passed: ${{'type': CaseStudy.value}}");
  }

  void onMainQuizTap() {
    Debug.setLog("Navigating to Timeline with Quiz type");
    Get.to(() => Timeline(), arguments: {'type': Quiz.value});
    Debug.setLog("Arguments passed: ${{'type': Quiz.value}}");
  }
}
