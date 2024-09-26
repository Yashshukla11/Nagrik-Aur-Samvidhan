import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/UI/Timeline/Components/Timeline.dart';
import '../UI/Auth/Components/Signup.dart';
import '../UI/Auth/Controller/SignupController.dart';
import '../UI/Chatbot/Controller/chatbotScreenController.dart';
import 'routes.dart';

import '../UI/Chatbot/Components/widgets/ChatbotScreen.dart';

class Pages {
  Pages._();

  static final pages = [
    GetPage(
        name: Routes.Chatbot_Screen,
        page: () => Chatbot_Screen(),
        popGesture: false,
        binding: BindingsBuilder(() {
          Get.lazyPut<ChatbotScreenController>(() => ChatbotScreenController());
        })),
    GetPage(
      name: Routes.Timeline,
      page: () => Timeline(),
      popGesture: false,
    ),
    GetPage(
      name: '/signup',
      page: () => SignupScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignupController>(() => SignupController());
      }),
    )
  ];
}
