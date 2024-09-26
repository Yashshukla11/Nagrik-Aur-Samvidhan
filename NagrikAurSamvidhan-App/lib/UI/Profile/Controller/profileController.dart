import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Constants.dart';

import '../../../Localization/Translation/localization_service.dart';
import '../../../Localization/Translation/translations.dart';
import '../../../Services/http_service.dart';
import '../../../Services/secured_storage.dart';

class ProfileController extends GetxController {
  final RxString _currentTheme = 'Light'.obs;
  final RxString _currentLanguage = 'English'.obs;
  final RxBool _isLoading = true.obs;
  final Rx<Map<String, dynamic>> _userData = Rx<Map<String, dynamic>>({});

  final List<String> themeOptions = ['Light', 'Dark'];

  List<LanguageModel> get languageOptions => languages;

  String get currentTheme => _currentTheme.value;

  String get currentLanguage => _currentLanguage.value;

  bool get isLoading => _isLoading.value;

  Map<String, dynamic> get userData => _userData.value;

  final HttpService _httpService = Get.find<HttpService>();
  final SecureStorage _secureStorage = Get.find<SecureStorage>();

  // Form controllers
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      _isLoading.value = true;
      final response = await _httpService.authenticatedRequest('/user/get');
      _userData.value = response;
      _populateTextControllers();
      Debug.setLog('----response-----${response}');
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  void _populateTextControllers() {
    nameController.text = userData['name'] ?? '';
    ageController.text = userData['age']?.toString() ?? '';
    genderController.text = userData['gender'] ?? '';
    phoneNumberController.text = userData['phoneNumber'] ?? '';
    addressController.text = userData['address'] ?? '';
    cityController.text = userData['city'] ?? '';
    stateController.text = userData['state'] ?? '';
  }

  Future<void> updateProfile() async {
    try {
      _isLoading.value = true;
      final updatedData = {
        "name": nameController.text,
        "password": "demo", // Note: You might want to handle this differently
        "age": ageController.text,
        "gender": genderController.text,
        "phoneNumber": phoneNumberController.text,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "language": currentLanguage,
      };

      final response =
          await _httpService.authenticatedPut('/user', body: updatedData);
      _userData.value = response;
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar('Error', 'Failed to update profile. Please try again.');
    } finally {
      _isLoading.value = false;
    }
  }

  void setTheme(String theme) {
    if (themeOptions.contains(theme)) {
      _currentTheme.value = theme;
      // Implement theme change logic here
    }
  }

  void setLanguage(LanguageModel language) {
    _currentLanguage.value = language.language;
    Get.find<LocalizationService>().changeLocale(language.languageCode);
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text('Logout'),
        content: Text('Do you want to logout?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () => _performLogout(),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogout() async {
    try {
      await _secureStorage.deleteToken();
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error during logout: $e');
      Get.back();
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    super.onClose();
  }
}
