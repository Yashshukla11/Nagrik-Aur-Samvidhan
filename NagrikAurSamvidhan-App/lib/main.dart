import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Auth/Components/Login.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Auth/Components/Signup.dart';
import 'package:nagrik_aur_samvidhan_app/UI/QuizzesList/components/QuizComponent.dart';
import 'Constants/Utils/main_container.dart';
import 'Localization/Translation/localization_service.dart';
import 'Localization/Translation/translations.dart';
import 'UI/splash/Component/splash.dart';
import 'Services/http_service.dart';
import 'Services/secured_storage.dart';
import 'Constants/app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() => SecureStorage.getInstance());
  Get.put(LocalizationService());
  Get.put(HttpService());
  Get.put(AppController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nagrik Aur Samvidhan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => MainContainer()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/main_quizzes', page: () => (QuizzesComponent())),
      ],
      translations: AppTranslation(),
      locale: Get.find<LocalizationService>().locale,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
