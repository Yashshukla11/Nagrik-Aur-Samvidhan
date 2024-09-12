import '../Constants.dart';

class AppUrls {
  AppUrls._();

  static String baseUrl =
      inDevelopment ? 'http://13.201.60.60:8000/' : 'http://13.201.60.60:8000/';
  static String apiBaseUrl = '$baseUrl';
  static String chatBotUrl =
      'https://rrarpy47de.execute-api.ap-south-1.amazonaws.com';
  static String uploadMediaUrl = '$apiBaseUrl/api/';

  static String isUserExistUrl(contact) =>
      '${apiBaseUrl}users/is-user-exist/$contact';

  static String imageUrl = '$baseUrl/assets/quizimageupload/';
  static String imagebaseurl = inDevelopment
      ? 'https://nagrikaursamvidhan-backend.onrender.com/'
      : 'https://nagrikaursamvidhan-backend.onrender.com/';
}
