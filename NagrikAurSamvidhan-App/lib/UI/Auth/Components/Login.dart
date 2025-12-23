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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20),
                            LogoWidget(),
                            SizedBox(height: 30),
                            // Compact login form container
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 400),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFB29F94), Color(0xFF603813)],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 15,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 32.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      EmailTextField(controller: controller),
                                      const SizedBox(height: 20),
                                      PasswordTextField(controller: controller),
                                      const SizedBox(height: 28),
                                      LoginButton(controller: controller),
                                      const SizedBox(height: 20),
                                      SignupText(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Bottom Image (fixed position)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            height: 100,
                            child: Image.asset(
                              'assets/auth/login1.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Image.asset(
        'assets/auth/logo.png',
        height: 120,
        width: 120,
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
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        hintText: 'Email',
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: MyColor.darkBlue, width: 2),
        ),
      ),
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      cursorColor: MyColor.darkBlue,
      keyboardType: TextInputType.emailAddress,
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
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: MyColor.darkBlue, width: 2),
        ),
      ),
      style: TextStyle(color: MyColor.black, fontWeight: FontWeight.w500),
      cursorColor: MyColor.darkBlue,
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            decoration: BoxDecoration(
              color:
                  controller.isLoading.value ? Colors.grey : MyColor.darkBlue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: MyColor.darkBlue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: controller.isLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
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
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
