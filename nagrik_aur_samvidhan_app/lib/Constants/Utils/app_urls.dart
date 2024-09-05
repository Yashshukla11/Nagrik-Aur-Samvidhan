import '../Constants.dart';

class AppUrls {
  AppUrls._();

  static String baseUrl = inDevelopment
      ? 'http://ec2-15-206-145-80.ap-south-1.compute.amazonaws.com:8000'
      : 'http://ec2-15-206-145-80.ap-south-1.compute.amazonaws.com:8000';
  static String apiBaseUrl = '$baseUrl';
  static String uploadMediaUrl = '$apiBaseUrl/api/';

  static String isUserExistUrl(contact) =>
      '${apiBaseUrl}users/is-user-exist/$contact';

  static String imageUrl = '$baseUrl/assets/quizimageupload/';
  static String imagebaseurl =
      inDevelopment ? 'http://192.168.1.48/' : 'http://192.168.1.48/';
}
