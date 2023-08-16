import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Prefs {
  static final serviceLocator = GetIt.instance;
  static Future<void> initPrefs() async {
    final serviceLocator = GetIt.instance;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    serviceLocator.registerSingleton<SharedPreferences>(sharedPref);
  }

  static SharedPreferences get _prefs =>
      serviceLocator.get<SharedPreferences>();

  static String getString(String key) => _prefs.getString(key) ?? '';

  static int getInt(String key) => _prefs.getInt(key) ?? -1;
  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);
  static Future<void> setInt(
      String key,
      int value,
      ) =>
      _prefs.setInt(key, value);
  static Future<void> setBool(
      String key,
      bool value,
      ) =>
      _prefs.setBool(key, value);

  /// clear all the prefs
  static Future<void> clear() => _prefs.clear();

  /// clear all the prefs
  static Future<void> clearKey(String key) => _prefs.remove(key);

  static Map<String, dynamic> getMap(
      String key,
      ) {
    final data = getString(key);
    return data.isEmpty ? {} : jsonDecode(data) as Map<String, dynamic>;
  }

  static Future<void> setMap(
      String key,
      Map<String, dynamic> map,
      ) =>
      setString(
        key,
        jsonEncode(map),
      );

  /// to make sure key exists
  static bool keyExists(String key) => _prefs.containsKey(key);
}