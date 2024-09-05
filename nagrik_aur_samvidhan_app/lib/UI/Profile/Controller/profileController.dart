import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Localization/Translation/localization_service.dart';
import '../../../Localization/Translation/translations.dart';
import '../../../Services/http_service.dart';
import '../../../Services/secured_storage.dart'; // Add this import

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
    } catch (e) {
      print('Error fetching user data: $e');
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
            onPressed: () => Get.back(), // Close the dialog
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
      await _secureStorage.deleteToken(); // Clear the stored token
      Get.offAllNamed(
          '/login'); // Navigate to login screen and remove all previous routes
    } catch (e) {
      print('Error during logout: $e');
      Get.back(); // Close the dialog
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
