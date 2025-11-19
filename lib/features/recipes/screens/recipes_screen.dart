import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_test_task/app/app_notifier.dart';
import 'package:recipes_test_task/app/app_state.dart';
import 'package:recipes_test_task/core/themes/theme_type.dart';
import 'package:recipes_test_task/features/recipes/provider/recipes_notifier.dart';
import 'package:recipes_test_task/features/recipes/provider/recipes_state.dart';
import 'package:recipes_test_task/features/recipes/widgets/empty_list_content.dart';
import 'package:recipes_test_task/features/recipes/widgets/error_content.dart';
import 'package:recipes_test_task/features/recipes/widgets/loading_content.dart';
import 'package:recipes_test_task/features/recipes/widgets/recepts_list.dart';

class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RecipesNotifier read = ref.read(recipesNotifierProvider.notifier);
    final RecipesState recipesState = ref.watch(recipesNotifierProvider);
    final AppNotifier appNotifier = ref.read(appNotifierProvider.notifier);
    final AppState appState = ref.watch(appNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепты'),
        centerTitle: true,
        actions: [
          // Кнопка переключения темы
          Row(
            children: [
              const Icon(Icons.light_mode),
              Switch(
                value: appState.themeType == ThemeType.dark,
                onChanged: (value) {
                  appNotifier.setTheme(
                    value ? ThemeType.dark : ThemeType.light,
                  );
                },
              ),
              const Icon(Icons.dark_mode),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: recipesState.isLoading
          ? LoadingContent()
          : (recipesState.errorMessage != null && (recipesState.errorMessage?.isNotEmpty ?? false))
          ? ErrorContent(
              errorMessage: recipesState.errorMessage ?? '',
              onRetryTap: () => read.getRecipes(needLoadingState: true),
            )
          : recipesState.recepts.isNotEmpty
          ? ReceptsList()
          : EmptyListContent(),
    );
  }
}
