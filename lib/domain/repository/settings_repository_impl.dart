import 'package:recipes_test_task/core/themes/theme_type.dart';
import 'package:recipes_test_task/data/local/settings_local_data_source.dart';
import 'package:recipes_test_task/data/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _settingsLocalDataSource;

  SettingsRepositoryImpl(this._settingsLocalDataSource);

  @override
  Future<void> saveTheme(ThemeType theme) async {
    await _settingsLocalDataSource.saveTheme(theme);
  }

  @override
  ThemeType getTheme() {
    final ThemeType theme = _settingsLocalDataSource.getTheme();
    return theme;
  }

  @override
  Future<void> clearAll() async {
    await _settingsLocalDataSource.clearAll();
  }
}
