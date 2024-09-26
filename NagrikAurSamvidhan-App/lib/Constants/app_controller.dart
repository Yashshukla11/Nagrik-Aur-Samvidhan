import 'package:get/get.dart';
import '../Services/http_service.dart';

class AppController extends GetxController {
  final HttpService _httpService = Get.find<HttpService>();

  Future<void> checkAuthAndRedirect() async {
    bool isValid = await _httpService.isTokenValid();

    if (isValid) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
