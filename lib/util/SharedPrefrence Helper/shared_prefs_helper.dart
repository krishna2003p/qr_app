import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences (Call this once in `main.dart`)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Set String Value
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// Get String Value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Set Integer Value
  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  /// Get Integer Value
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Set Boolean Value
  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  /// Get Boolean Value
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Set Double Value
  static Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  /// Get Double Value
  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  /// Set List of Strings
  static Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  /// Get List of Strings
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  /// Remove Key
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// Clear All Data
  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
