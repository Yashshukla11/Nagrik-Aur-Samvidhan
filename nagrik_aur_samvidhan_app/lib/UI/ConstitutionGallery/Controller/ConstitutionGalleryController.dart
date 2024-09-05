//myapp

import 'package:flutter/foundation.dart';

class ConstitutionGalleryController {
  // Use ValueNotifier to notify changes if needed
  static ValueNotifier<List<String>> pagesNotifier =
      ValueNotifier(_getConstitutionPages());

  static List<String> getConstitutionPages() {
    return _getConstitutionPages();
  }

  // List of image assets (modify with actual paths)
  static List<String> _getConstitutionPages() {
    return List.generate(
      25, // Create a grid of 5x5 images (adjust size as needed)
      (index) => 'assets/ChatBot/backfinal.jpg',
    );
  }
}
