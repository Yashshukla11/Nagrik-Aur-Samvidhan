import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Auth/Components/Signup.dart';
import '../Controller/LoginController.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nagrik aur Samvidhan - Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: controller.setEmail,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: controller.setPassword,
            ),
            const SizedBox(height: 24),
            Obx(() => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.login,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                )),
            GestureDetector(
              onTap: () => Get.to(() => SignupScreen()),
              child: const Text("Don't have a account , SignUp"),
            )
          ],
        ),
      ),
    );
  }
}
