import 'package:flutter/material.dart';

class Utils {
  static final ValueNotifier<Locale> appLocal =
      ValueNotifier<Locale>(const Locale('en', 'US'));
  static bool isTablet = false;

  static void setLog(String message) {
    // In a real app, you might want to use a proper logging library
    print(message);
  }
}

class Debug {
  static void setLog(String message) {
    // This is just a simple implementation. In a real app, you might want to
    // add more sophisticated logging logic.
    print("DEBUG: $message");
  }
}
