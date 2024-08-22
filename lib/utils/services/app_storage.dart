import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static SharedPreferences? _sharedPreferences;
  static AppStorage? _instance;

  AppStorage._();

  static Future<AppStorage> getInstance() async {
    if (_sharedPreferences == null) {
      await _initializeSharedPreference();
    }

    _instance ??= AppStorage._();
    return _instance ?? AppStorage._();
  }

  static Future<void> _initializeSharedPreference() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  String getStringValue({required String key}) {
    String value = '';
    value = _sharedPreferences?.getString(key) ?? '';
    return value;
  }

  Future<int?> getIntValue({required String key}) async {
    int? value;
    value = _sharedPreferences?.getInt(key);
    return value;
  }

  double? getDoubleValue({required String key}) {
    double? value;
    value = _sharedPreferences?.getDouble(key);
    return value;
  }

  bool? getBoolValue({required String key}) {
    bool? value;
    value = _sharedPreferences?.getBool(key);
    return value;
  }

  List<String> getListOfString({required String key}) {
    List<String> value = [];
    value = _sharedPreferences?.getStringList(key) ?? [];
    return value;
  }

  Future<bool> setStringValue({required String key, required String value}) async {
    return await _sharedPreferences?.setString(key, value) ?? false;
  }

  Future<bool> setIntValue({required String key, required int value}) async {
    return await _sharedPreferences?.setInt(key, value) ?? false;
  }

  Future<bool> setDoubleValue({required String key, required double value}) async {
    return await _sharedPreferences?.setDouble(key, value) ?? false;
  }

  Future<bool> setBoolValue({required String key, required bool value}) async {
    return await _sharedPreferences?.setBool(key, value) ?? false;
  }

  Future<bool> setListOfString({required String key, required List<String> value}) async {
    return await _sharedPreferences?.setStringList(key, value) ?? false;
  }

  Future<bool> clearAllValues() async {
    return await _sharedPreferences?.clear() ?? false;
  }

  Future<bool> removeKeyValue({required String key}) async {
    return await _sharedPreferences?.remove(key) ?? false;
  }

  bool containsKey({required String key}) {
    return _sharedPreferences?.containsKey(key) ?? false;
  }

  Set<String> getAllKeys() {
    return _sharedPreferences?.getKeys() ?? {};
  }
}
