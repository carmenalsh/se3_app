import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  //! init
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    } else {
      throw Exception('Unsupported value type for CacheHelper.saveData');
    }
  }

  //! get typed string
  static String? getDataString({required String key}) {
    return _sharedPreferences.getString(key);
  }

  //! get any type
  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  //! remove specific key
  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  //! contains key
  static bool containsKey({required String key}) {
    return _sharedPreferences.containsKey(key);
  }

  //! clear all
  static Future<bool> clearData() async {
    return await _sharedPreferences.clear();
  }
}
