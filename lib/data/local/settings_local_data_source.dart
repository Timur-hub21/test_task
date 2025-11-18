import 'package:recipes_test_task/core/themes/theme_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDataSource {
  static const String _keyTheme = 'theme';

  late final SharedPreferences _prefs;
  bool _isInitialized = false;

  SettingsLocalDataSource();

  Future<void> init() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  /// Сохраняем выбранную тему
  Future<void> saveTheme(ThemeType theme) async {
    await _prefs.setInt(_keyTheme, theme.index);
  }

  ThemeType getTheme() {
    final int? index = _prefs.getInt(_keyTheme);
    if (index == null) return ThemeType.device;
    return ThemeType.values[index];
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
