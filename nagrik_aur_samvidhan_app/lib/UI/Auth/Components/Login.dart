import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Auth/Components/Signup.dart';

import '../../../Values/values.dart';
import '../Controller/LoginController.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/auth/backnew.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      LogoWidget(),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFB29F94), Color(0xFF603813)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 24),
                                  EmailTextField(controller: controller),
                                  const SizedBox(height: 16),
                                  PasswordTextField(controller: controller),
                                  const SizedBox(height: 24),
                                  LoginButton(controller: controller),
                                  const SizedBox(height: 24),
                                  SignupText(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Bottom Image (fixed position)
                      SizedBox(
                        height: 100,
                        child: Image.asset(
                          'assets/auth/login1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          // BoxShadow(
          //   color: Colors.white,
          //   blurRadius: 50.0,
          //   spreadRadius: 0.0,
          //   offset: Offset(0, 5),
          // ),
        ],
      ),
      child: Image.asset(
        'assets/auth/logo.png',
        height: Sizes.HEIGHT_200,
        width: Sizes.WIDTH_200,
        fit: BoxFit.cover,
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final LoginController controller;

  const EmailTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'Email',
        fillColor: Colors.white,
        hoverColor: MyColor.black,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      onChanged: controller.setEmail,
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final LoginController controller;

  const PasswordTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(),
        filled: true,
        fillColor: MyColor.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: TextStyle(color: MyColor.black),
      cursorColor: Colors.black,
      obscureText: true,
      onChanged: controller.setPassword,
    );
  }
}

class LoginButton extends StatelessWidget {
  final LoginController controller;

  const LoginButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: controller.isLoading.value ? null : controller.login,
          // onTap: () async {
          //   // bool success = await controller.login();
          //   // if (success) {
          //   Get.to(() => HomeScreen());
          //   // }
          // },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              color:
                  controller.isLoading.value ? Colors.grey : MyColor.darkBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}

class SignupText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => SignupScreen()),
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(color: MyColor.darkBlue),
            ),
          ],
        ),
      ),
    );
  }
}
