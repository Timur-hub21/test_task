import 'dart:developer';

import 'package:recipes_test_task/app/app_state.dart';
import 'package:recipes_test_task/app/di/di.dart';
import 'package:recipes_test_task/core/themes/theme_type.dart';
import 'package:recipes_test_task/data/local/settings_local_data_source.dart';
import 'package:recipes_test_task/data/repository/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_notifier.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  late SettingsLocalDataSource _settingsLocalDataSource;
  late SettingsRepository _settingsRepository;

  @override
  AppState build() {
    ref.keepAlive();
    _settingsLocalDataSource = ref.watch(settingsLocalDataSourceProvider);
    _settingsRepository = ref.read(settingsRepositoryProvider);

    Future(applyCurrentTheme);

    return AppState.initialize();
  }

  Future<void> applyCurrentTheme() async {
    await _settingsLocalDataSource.init();
    state = state.copyWith(themeType: _settingsRepository.getTheme());
    log(state.themeType.toString());
  }

  Future<void> setTheme(ThemeType theme) async {
    await _settingsRepository.saveTheme(theme);
    state = state.copyWith(themeType: theme);
  }
}
