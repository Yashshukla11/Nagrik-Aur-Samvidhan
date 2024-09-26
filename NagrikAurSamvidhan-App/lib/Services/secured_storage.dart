import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';

class SecureStorage extends GetxService {
  static SecureStorage? _instance;
  late FlutterSecureStorage _prefs;

  static Future<SecureStorage> getInstance() async {
    if (_instance == null) {
      _instance = SecureStorage._();
      await _instance!._init();
    }
    return _instance!;
  }

  SecureStorage._();

  Future<void> _init() async {
    _prefs = const FlutterSecureStorage();
  }

  IOSOptions getIOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

  Future<AndroidOptions> getAndroidOptions() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: packageInfo.packageName,
      preferencesKeyPrefix: packageInfo.packageName,
    );
  }

  // String operations
  Future<void> setString(String key, String value) async {
    await _prefs.write(
        key: key,
        value: value,
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
  }

  Future<String> getString(String key) async {
    return await _prefs.read(
            key: key,
            iOptions: getIOSOptions(),
            aOptions: await getAndroidOptions()) ??
        '';
  }

  // Bool operations
  Future<void> setBool(String key, bool value) async {
    await _prefs.write(
        key: key,
        value: value.toString(),
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
  }

  Future<bool> getBool(String key) async {
    String value = await _prefs.read(
            key: key,
            iOptions: getIOSOptions(),
            aOptions: await getAndroidOptions()) ??
        'false';
    return value == 'true';
  }

  // Double operations
  Future<void> setDouble(String key, double value) async {
    await _prefs.write(
        key: key,
        value: value.toString(),
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
  }

  Future<double?> getDouble(String key) async {
    String? value = await _prefs.read(
        key: key,
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
    return value != null ? double.tryParse(value) : null;
  }

  // Integer operations
  Future<void> setInt(String key, int value) async {
    await _prefs.write(
        key: key,
        value: value.toString(),
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
  }

  Future<int?> getInt(String key) async {
    String? value = await _prefs.read(
        key: key,
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
    return value != null ? int.tryParse(value) : null;
  }

  // List<String> operations
  Future<void> setStringList(String key, List<String> value) async {
    String list = value.join(',');
    await _prefs.write(
        key: key,
        value: list,
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
  }

  Future<List<String>> getStringList(String key) async {
    String? value = await _prefs.read(
        key: key,
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
    return value?.split(',') ?? [];
  }

  Future<void> clearAll() async {
    await _prefs.deleteAll(
        iOptions: getIOSOptions(), aOptions: await getAndroidOptions());
  }

  // Token-specific methods
  Future<void> saveToken(String token) async {
    await setString('auth_token', token);
  }

  Future<String?> getToken() async {
    return getString('auth_token');
  }

  Future<void> deleteToken() async {
    await _prefs.delete(
        key: 'auth_token',
        iOptions: getIOSOptions(),
        aOptions: await getAndroidOptions());
  }
}
