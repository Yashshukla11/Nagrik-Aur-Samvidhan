import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';

class SignupController extends GetxController {
  final _name = ''.obs;
  final _email = ''.obs;
  final _password = ''.obs;
  final _age = ''.obs;
  final gender = Rx<String?>(null);
  final _phoneNumber = ''.obs;
  final language = Rx<String?>(null);
  final isLoading = false.obs;

  void setName(String value) => _name.value = value;

  void setEmail(String value) => _email.value = value;

  void setPassword(String value) => _password.value = value;

  void setAge(String value) => _age.value = value;

  void setGender(String? value) => gender.value = value;

  void setPhoneNumber(String value) => _phoneNumber.value = value;

  void setLanguage(String? value) => language.value = value;

  void register() async {
    if (_name.value.isEmpty ||
        _email.value.isEmpty ||
        _password.value.isEmpty ||
        _age.value.isEmpty ||
        gender.value == null ||
        _phoneNumber.value.isEmpty ||
        language.value == null) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('${AppUrls.baseUrl}/user/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": _email.value,
          "password": _password.value,
          "name": _name.value,
          "age": _age.value,
          "gender": gender.value,
          "phoneNumber": _phoneNumber.value,
          "language": language.value,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Registration successful');
        // Navigate to login page or directly to home page
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Error', 'Registration failed: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
