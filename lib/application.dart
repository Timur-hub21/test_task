import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_test_task/app/app_notifier.dart';
import 'package:recipes_test_task/app/app_state.dart';
import 'package:recipes_test_task/app/router/app_router.dart';
import 'package:recipes_test_task/core/themes/app_theme.dart';
import 'package:recipes_test_task/core/themes/theme_type.dart';

class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => _ApplicationState();
}

class _ApplicationState extends ConsumerState<Application> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final ThemeType? themeType = ref.read(appNotifierProvider).themeType;

    if (themeType == ThemeType.device) {
      ref.read(appNotifierProvider.notifier).applyCurrentTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter router = ref.watch(routerProvider);
    final AppState appState = ref.watch(appNotifierProvider);
    final ThemeType themeType = appState.themeType ?? ThemeType.device;

    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: switch (themeType) {
        ThemeType.light => ThemeMode.light,
        ThemeType.dark => ThemeMode.dark,
        ThemeType.device => ThemeMode.system,
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
