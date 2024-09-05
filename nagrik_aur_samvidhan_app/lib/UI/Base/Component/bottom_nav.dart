import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Values/values.dart';
import '../Controller/bottom_nav_controller.dart';

class BottomNav extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE27D4E), Color(0xFFEEB68C)],
              begin: Alignment(0.0, 0.0),
              end: Alignment(0.74, 1.0),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeIndex,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              enableFeedback: false,
              items: [
                _buildNavItem(
                    'assets/bottom_nav/home.png', MyString.home.tr, 0),
                _buildNavItem(
                    'assets/bottom_nav/quiz1.png', MyString.Quiz.tr, 1),
                _buildNavItem(
                    'assets/bottom_nav/chat.png', MyString.chatBot.tr, 2),
                _buildNavItem(
                    'assets/bottom_nav/kid.png', MyString.Profile.tr, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String iconPath, String label, int index) {
    final bool isSelected = controller.selectedIndex.value == index;
    final double size = isSelected ? 32 : 28; // Increase size when selected

    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: size,
        height: size,
      ),
      label: label,
    );
  }
}
