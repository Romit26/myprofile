import 'package:shared_preferences/shared_preferences.dart';

///preference repository for managing local data
class PreferenceRepository {
  Future<SharedPreferences> getPref() async =>
      await SharedPreferences.getInstance();

  Future<bool> setString(String key, String? value) async {
    if (value != null) {
      return (await getPref()).setString(key, value);
    } else {
      return false;
    }
  }

  Future<bool> setBool(String key, bool? value) async {
    if (value != null) {
      return (await getPref()).setBool(key, value);
    } else {
      return false;
    }
  }

  Future<String?> getPrefString(String key) async =>
      (await getPref()).getString(key);

  Future<bool?> getPrefBoolean(String key) async =>
      (await getPref()).getBool(key);

  Future<bool> removeValue(String key) async => (await getPref()).remove(key);
}
