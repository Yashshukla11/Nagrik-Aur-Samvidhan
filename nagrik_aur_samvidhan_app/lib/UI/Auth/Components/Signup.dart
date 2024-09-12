import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Values/values.dart';
import '../Controller/SignupController.dart';

class SignupScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/auth/backnew.jpg',
              fit: BoxFit.cover,
            ),
          ),
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
                              horizontal: 16.0, vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFB29F94), Color(0xFF603813)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 24),
                                NameTextField(controller: controller),
                                const SizedBox(height: 16),
                                EmailTextField(controller: controller),
                                const SizedBox(height: 16),
                                PasswordTextField(controller: controller),
                                const SizedBox(height: 16),
                                AgeTextField(controller: controller),
                                const SizedBox(height: 16),
                                GenderDropdown(controller: controller),
                                const SizedBox(height: 16),
                                PhoneTextField(controller: controller),
                                const SizedBox(height: 16),
                                LanguageDropdown(controller: controller),
                                const SizedBox(height: 24),
                                SignupButton(controller: controller),
                                const SizedBox(height: 16),
                                LoginText(),
                                const SizedBox(height: 16),
                              ],
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
          BoxShadow(
            color: Colors.white,
            blurRadius: 50.0,
            spreadRadius: 0.0,
            offset: Offset(0, 5),
          ),
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

class NameTextField extends StatelessWidget {
  final SignupController controller;

  const NameTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'Name'.tr,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      onChanged: controller.setName,
    );
  }
}

class EmailTextField extends StatelessWidget {
  final SignupController controller;

  const EmailTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'Email'.tr,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      onChanged: controller.setEmail,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final SignupController controller;

  const PasswordTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'Password'.tr,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      onChanged: controller.setPassword,
      obscureText: true,
    );
  }
}

class AgeTextField extends StatelessWidget {
  final SignupController controller;

  const AgeTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'Age'.tr,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      onChanged: controller.setAge,
      keyboardType: TextInputType.number,
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String hint;
  final void Function(T?)? onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<T>(
            value: value,
            hint: Text(hint, style: TextStyle(color: Colors.black)),
            items: items,
            onChanged: onChanged,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            dropdownColor: Colors.white,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
            menuMaxHeight: 300,
          ),
        ),
      ),
    );
  }
}

class GenderDropdown extends StatelessWidget {
  final SignupController controller;

  const GenderDropdown({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomDropdown<String>(
          hint: 'Gender'.tr,
          value: controller.gender.value,
          onChanged: controller.setGender,
          items: ['Male', 'Female', 'Other'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.tr),
            );
          }).toList(),
        ));
  }
}

class PhoneTextField extends StatelessWidget {
  final SignupController controller;

  const PhoneTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'Phone Number'.tr,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      onChanged: controller.setPhoneNumber,
      keyboardType: TextInputType.phone,
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  final SignupController controller;

  const LanguageDropdown({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomDropdown<String>(
          hint: 'Language'.tr,
          value: controller.language.value,
          onChanged: controller.setLanguage,
          items: [
            'English',
            'Hindi',
            'Telugu',
            'Tamil',
            'Marathi',
            'Bengali',
            'Gujarati',
            'Kannada'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.tr),
            );
          }).toList(),
        ));
  }
}

class SignupButton extends StatelessWidget {
  final SignupController controller;

  const SignupButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: controller.isLoading.value ? null : controller.register,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              color:
                  controller.isLoading.value ? Colors.grey : MyColor.darkBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Sign Up'.tr,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}

class LoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: TextStyle(color: MyColor.white),
          children: <TextSpan>[
            TextSpan(
              text: 'Login',
              style: TextStyle(color: MyColor.darkBlue),
            ),
          ],
        ),
      ),
    );
  }
}
