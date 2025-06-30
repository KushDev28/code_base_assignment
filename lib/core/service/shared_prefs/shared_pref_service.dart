import 'package:shared_preferences/shared_preferences.dart';


///Shared pref Service of the application
class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesService();
      await _instance!._init();
    }
    return _instance!;
  }

  // to clear a preference
  Future<void> clearPreferences() async {
    await _preferences?.clear();
  }

  // to read a string preference
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  // to remove a particular preference key
  Future<void> removePreference(String key) async {
    await _preferences?.remove(key);
  }

  // to write a string preference
  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }


}
