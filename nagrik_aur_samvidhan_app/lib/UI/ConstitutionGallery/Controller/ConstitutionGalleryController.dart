import 'package:get/get.dart';

import '../../../Services/http_service.dart';

class ConstitutionPage {
  final String id;
  final String image;
  final String title;
  final String type;
  String? summary;

  ConstitutionPage({
    required this.id,
    required this.image,
    required this.title,
    required this.type,
    this.summary,
  });

  factory ConstitutionPage.fromJson(Map<String, dynamic> json) {
    return ConstitutionPage(
      id: json['_id'],
      image: json['image'],
      title: json['title'],
      type: json['type'],
    );
  }
}

class ConstitutionGalleryController extends GetxController {
  final HttpService _httpService = Get.find<HttpService>();
  RxString userLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserLanguage();
  }

  Future<void> fetchUserLanguage() async {
    try {
      final response = await _httpService.authenticatedRequest('/user/get');
      userLanguage.value = response['language'] ?? 'English';
    } catch (e) {
      print('Error fetching user language: $e');
      // Default to English if there's an error
      userLanguage.value = 'English';
    }
  }

  static Future<List<ConstitutionPage>> fetchConstitutionPages() async {
    try {
      final HttpService httpService = Get.find<HttpService>();
      final response = await httpService.authenticatedRequestGeneral('/grid');

      if (response is List) {
        List<ConstitutionPage> pages =
            response.map((data) => ConstitutionPage.fromJson(data)).toList();

        pages.sort((a, b) {
          if (a.type == "0") return 1;
          if (b.type == "0") return -1;
          return 0;
        });

        return pages;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error fetching constitution pages: $e');
      throw Exception('Failed to load constitution pages');
    }
  }

  Future<String> fetchSummary(String title) async {
    try {
      final response = await _httpService.authenticatedPost(
        '/get_summary',
        data: {
          'user_prompt': title,
          'language': userLanguage.value,
        },
        useAiUrl: true,
      );
      return response['summary'] ?? 'No summary available.';
    } catch (e) {
      print('Error fetching summary: $e');
      return 'Failed to load summary.';
    }
  }
}
