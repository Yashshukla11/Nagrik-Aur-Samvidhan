import 'package:get/get.dart';
import '../../../Constants/app_controller.dart';
import '../../../Services/http_service.dart';
import '../../../Services/secured_storage.dart';

class LoginController extends GetxController {
  final _email = ''.obs;
  final _password = ''.obs;
  final isLoading = false.obs;

  late final HttpService _httpService;
  late final SecureStorage _secureStorage;
  late final AppController _appController;

  @override
  void onInit() {
    super.onInit();
    _httpService = Get.find<HttpService>();
    _secureStorage = Get.find<SecureStorage>();
    _appController = Get.find<AppController>();
  }

  void setEmail(String email) => _email.value = email;

  void setPassword(String password) => _password.value = password;

  Future<void> login() async {
    if (_email.value.isEmpty || _password.value.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password.',
          snackPosition: SnackPosition.TOP);
      return;
    }

    isLoading.value = true;

    try {
      final response = await _httpService.login(_email.value, _password.value);

      if (response['token'] != null) {
        // Save the token
        await _secureStorage.saveToken(response['token']);

        Get.snackbar('Success', 'Login successful!',
            snackPosition: SnackPosition.TOP);
        _appController
            .checkAuthAndRedirect(); // Use AppController for navigation
      } else {
        Get.snackbar('Error', 'Login failed. Please try again.',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
