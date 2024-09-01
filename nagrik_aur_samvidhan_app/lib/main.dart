import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Constants/Utils/main_container.dart';
import 'UI/splash/Component/splash.dart';
import 'Constants/Utils/main_container.dart';

void main() {
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
        GetPage(name: '/home', page: () => MainContainer()),
      ],
    );
  }
}
