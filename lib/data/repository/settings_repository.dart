import 'package:recipes_test_task/core/themes/theme_type.dart';

abstract interface class SettingsRepository {
  Future<void> saveTheme(ThemeType themeType);

  ThemeType getTheme();

  Future<void> clearAll();
}
