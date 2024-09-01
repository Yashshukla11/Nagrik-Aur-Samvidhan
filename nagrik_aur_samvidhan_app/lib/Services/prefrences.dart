import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? prefs;

  static Preferences? _instance;

  factory Preferences() => _instance ??= Preferences._();

  Preferences._();

  Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  // ------------------------------------------------------------------
  // ---------------------- String ----------------------

  static Future<bool> setPrefString(String key, String value) async {
    return await prefs!.setString(key, value);
  }

  static String getPrefString(String key) => prefs!.getString(key) ?? '';

  // ---------------------- Bool ----------------------

  static Future setPrefBool(String key, bool value) async {
    return await prefs!.setBool(key, value);
  }

  static bool getPrefBool(String key) => prefs!.getBool(key) ?? false;

  // ---------------------- Double ----------------------

  static Future setPrefDouble(String key, double value) async =>
      await prefs!.setDouble(key, value);

  static double getPrefDouble(String key) => prefs!.getDouble(key) ?? 0.0;

  // ---------------------- Integer ----------------------

  static Future setPrefInteger(String key, int value) async =>
      await prefs!.setInt(key, value);

  static int getPrefInteger(String key) => prefs!.getInt(key) ?? 0;

  // ---------------------- List<String> ----------------------

  static Future setPrefListString(String key, List<String> value) async =>
      await prefs!.setStringList(key, value);

  static List<String> getPrefListString(String key) =>
      prefs!.getStringList(key) ?? [];

  // ------------------------------------------------------------------

  static Future clearAllPrefs() async => await prefs!.clear();

  Future<void> deletePrefs(String key) async => await prefs?.remove(key);
}
