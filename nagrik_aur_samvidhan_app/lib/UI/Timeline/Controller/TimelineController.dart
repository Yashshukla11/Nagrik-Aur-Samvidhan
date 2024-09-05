import 'package:get/get.dart';

class TimelineController extends GetxController {
  // List of levels with their status
  var levels = [
    {'name': 'Beginner', 'status': 'locked'},
    {'name': 'Intermediate', 'status': 'locked'},
    {'name': 'Advanced', 'status': 'locked'},
    {'name': 'Expert', 'status': 'locked'},
    {'name': 'Master', 'status': 'locked'},
  ].obs;

  // Function to unlock the next level
  void unlockLevel(int index) {
    if (index < levels.length) {
      levels[index]['status'] = 'unlocked';
      update();
    }
  }

  // Function to check if a level is unlocked
  bool isLevelUnlocked(int index) {
    return levels[index]['status'] == 'unlocked';
  }

  // Function to reset all levels (if needed)
  void resetLevels() {
    for (var i = 1; i < levels.length; i++) {
      levels[i]['status'] = 'locked';
    }
    update();
  }
}
