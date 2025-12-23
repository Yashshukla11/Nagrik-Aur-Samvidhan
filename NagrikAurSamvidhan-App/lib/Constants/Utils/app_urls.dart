import '../Constants.dart';

class AppUrls {
  AppUrls._();

  static String baseUrl = inDevelopment
      ? 'https://nagrikaursamvidhan-backend-1-b1vm.onrender.com/'
      : 'https://nagrikaursamvidhan-backend-1-b1vm.onrender.com/';
  static String apiBaseUrl = '$baseUrl';
  static String chatBotUrl = 'http://localhost:8000';

  static String AiBotUrl = 'http://localhost:8000';
  static String uploadMediaUrl = '$apiBaseUrl/api/';

  static String isUserExistUrl(contact) =>
      '${apiBaseUrl}users/is-user-exist/$contact';

  static String imageUrl = '$baseUrl/assets/quizimageupload/';
  static String imagebaseurl = inDevelopment
      ? 'https://nagrikaursamvidhan-backend.onrender.com/'
      : 'https://nagrikaursamvidhan-backend.onrender.com/';
}
