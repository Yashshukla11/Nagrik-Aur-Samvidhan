import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Constants/Utils/app_urls.dart';
import 'secured_storage.dart';

class HttpService extends GetxService {
  late Dio _dio;
  final String baseUrl = AppUrls.baseUrl; // Replace with your actual base URL
  late final SecureStorage _secureStorage;

  @override
  void onInit() {
    super.onInit();
    _secureStorage = Get.find<SecureStorage>();
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio
          .post('/user/login', data: {'email': email, 'password': password});
      return response.data;
    } on DioError catch (e) {
      throw e.message ?? 'An error occurred';
    }
  }

  Future<bool> isTokenValid() async {
    try {
      final token = await _secureStorage.getToken();
      if (token == null) return false;

      final response = await _dio.get('/user/get',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> authenticatedRequest(String path,
      {String method = 'GET', Map<String, dynamic>? data}) async {
    try {
      final token = await _secureStorage.getToken();
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: data,
      );
      return response.data;
    } on DioError catch (e) {
      throw e.message ?? 'An error occurred';
    }
  }
}
