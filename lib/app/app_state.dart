import 'package:recipes_test_task/core/themes/theme_type.dart';

final class AppState {
  final ThemeType? themeType;

  const AppState({
    this.themeType,
  });

  factory AppState.initialize() => const AppState();

  AppState copyWith({
    ThemeType? themeType,
  }) {
    return AppState(
      themeType: themeType ?? this.themeType,
    );
  }
}
