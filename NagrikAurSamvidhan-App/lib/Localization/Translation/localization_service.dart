import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'translations.dart';

class LocalizationService extends GetxService {
  static LocalizationService get instance => Get.find<LocalizationService>();

  // Make locale observable
  final Rx<Locale?> _locale = Get.deviceLocale.obs;
  final Locale _fallbackLocale = const Locale('en', 'US');

  Locale get locale => _locale.value ?? _fallbackLocale;

  void changeLocale(String languageCode) {
    final newLocale = _getLocaleFromLanguage(languageCode);
    if (newLocale != null) {
      _locale.value = newLocale; // Update the observable
      Get.updateLocale(newLocale); // Update the locale in GetX
    }
  }

  Locale? _getLocaleFromLanguage(String languageCode) {
    for (int i = 0; i < languages.length; i++) {
      if (languages[i].languageCode == languageCode) {
        return Locale(languageCode.split('_')[0], languageCode.split('_')[1]);
      }
    }
    return Get.locale;
  }
}
