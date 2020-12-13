import 'package:shared_preferences/shared_preferences.dart';

const _isDisplayAlwaysOnKey = 'is-display-always-on';

class SettingsRepository {
  Future<bool> isDisplayAlwaysOn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDisplayAlwaysOnKey);
  }

  Future<void> setIsDisplayAlwaysOn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDisplayAlwaysOnKey, value);
  }
}
