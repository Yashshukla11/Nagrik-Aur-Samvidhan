import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/SignupController.dart';

class SignupScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signup'.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'name'.tr),
              onChanged: controller.setName,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'email'.tr),
              onChanged: controller.setEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'password'.tr),
              onChanged: controller.setPassword,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'age'.tr),
              onChanged: controller.setAge,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'gender'.tr),
              items: ['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.tr),
                );
              }).toList(),
              onChanged: controller.setGender,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'phone_number'.tr),
              onChanged: controller.setPhoneNumber,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'language'.tr),
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
              onChanged: controller.setLanguage,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.register,
              child: Text('sign_up'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
