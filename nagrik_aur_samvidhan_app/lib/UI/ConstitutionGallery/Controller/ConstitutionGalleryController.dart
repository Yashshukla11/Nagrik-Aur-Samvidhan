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
    return [
      'assets/imgLibrary/img1.jpg',
      'assets/imgLibrary/img2.jpg',
      'assets/imgLibrary/img3.jpg',
      'assets/imgLibrary/img4.jpg',
      'assets/imgLibrary/img5.jpg',
      'assets/imgLibrary/img6.jpg',
      'assets/imgLibrary/img7.jpg',
      'assets/imgLibrary/img8.jpg',
      'assets/imgLibrary/img9.jpg',
      'assets/imgLibrary/img10.jpg',
      'assets/imgLibrary/img11.jpg',
      'assets/imgLibrary/img12.jpg',
      'assets/imgLibrary/img1.jpg',
      'assets/imgLibrary/img2.jpg',
      'assets/imgLibrary/img3.jpg',
      'assets/imgLibrary/img4.jpg',
      'assets/imgLibrary/img5.jpg',
      'assets/imgLibrary/img6.jpg',
      'assets/imgLibrary/img7.jpg',
      'assets/imgLibrary/img8.jpg',
      'assets/imgLibrary/img9.jpg',
      'assets/imgLibrary/img10.jpg',
      'assets/imgLibrary/img11.jpg',
      'assets/imgLibrary/img12.jpg',
      'assets/imgLibrary/img12.jpg',
    ];
  }
}
