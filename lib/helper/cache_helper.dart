import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;



  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///set-get-remove-clear

  static Future<bool> savePrefs(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }

    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getPrefs({required String key}) {
    return sharedPreferences.get(key);
  }

  static List<String>? getPrefsList({required String key}) {
    return sharedPreferences.getStringList(key);
  }

  static dynamic savePrefsList(
      {required String key, required List<String> value}) {
    return sharedPreferences.setStringList(key, value);
  }

  static Future<bool> clearPrefs({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearAll() async {
    return await sharedPreferences.clear();
  }
}
