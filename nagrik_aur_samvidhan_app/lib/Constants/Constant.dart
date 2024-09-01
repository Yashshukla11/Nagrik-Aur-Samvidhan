import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../Values/values.dart';

const debug = true;
const countToastDebug = false;
const inDevelopment = true;

Logger logger = Logger();

const appScreenSize = Size(750, 1624);
final double screenWidth = ScreenUtil().screenWidth;
final double screenHeight = ScreenUtil().screenWidth;
final double screenHeightOrg = ScreenUtil().screenHeight;

Duration commonDuration = const Duration(milliseconds: 400);
Duration animDuration = const Duration(milliseconds: 400);

// Shared Preference
const isUserLoggedPref = 'Is User Logged In Preference';
const isNotFirstTimePref = 'Is App Not Open Time Preference';
const rolePref = 'Role Preference';
const searchFirstPref = 'Is Search First Preference';
const submitQuizData = 'Submit Quiz Data';

// Secure Shared Preference
const userDataPref = 'User Data preference';
const tokenPref = 'Token preference';
const questionDatapref = 'Question Data preference';

// Notification
const scheduleNotification = 'scheduleNotification';

//hero animation key
const loginHero = 'Login hero key';
const forgotScreenHero = 'Forgot Screen hero key';
const verifyScreenHero = 'Verify Screen hero key';
const signInImageHero = 'Sign In Image Hero';

// Argument data
// const roleTitleArg = 'Role Title Argument';
const String forgotPasswordArg = 'Forgot Password Response Data Argument';
const String schoolDataArg = 'School Data Argument';
const String teacherClassIdArg = 'Teacher Class Id Argument';
const String teacherClassNameArg = 'Teacher Class Name Argument';
const String type = 'Type';
const String studentDataArg = 'Student Data Argument';
const String teacherIdArg = 'Teacher Id';
const String teacherDataArg = 'Teacher Data Argument';
const String indexArg = 'Index Data Argument';
const String classDataArg = 'Class Data Argument';
const String subjectDataArg = 'Subject Data Argument';
const String chapterDataArg = 'Chapter Data Argument';
const String subTopicDataArg = 'Sub Topic Data Argument';
const String quizIdArg = 'Quiz Id Argument';
const String quizTypeArg = 'Quiz Type Argument';

const String studentIdArg = 'studentIdArg';
// const String quizTypeArg = 'Quiz Type Argument';
const String screScreenArg = 'Score Screen Argument';

const String quizDataArg = 'Quiz Data Argument';
const String baseArgPageIndex = 'baseArgPageIndex ';

const String profileDataArg = 'Profile Data Argument';

const String quizNameArg = 'Quiz Name Argument';
const String quizTimeArg = 'Quiz Time Arguments';
const String subNameArg = 'Sub Name Arg';
const String subIdArg = 'Sub Id Arg';

const String schoolIdArg = 'SchoolId';
const String classIdArg = 'classId';
const String classNameArg = 'classNameArg';
const String checkPage = 'Chaeck Page';

//api response strings
const userRes = 'user';
const dataRes = 'data';
const offersRes = 'offers';
const weekArg = 'Week Argument';
const monthArg = 'Month Argument';
const typeArg = 'Type Argument';
const subjectIdArg = 'Subject Id Argument';

DateFormat fullNumberDateFormat = DateFormat('dd-MM-yyyy');

class Debug {
  Debug._();

  static void setLog(String val) {
    if (debug) logger.d(val);
  }

  static void setErrorLog(String val) {
    if (debug) logger.e(val);
  }
}

void showOverlayProgressBar({Future Function()? close}) {
  Get.showOverlay(
    asyncFunction: close!,
    loadingWidget: const Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(MyColor.blue),
          backgroundColor: Colors.white),
    ),
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}
