import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_test_task/features/recipe_detail/screens/recipe_detail_screen.dart';
import 'package:recipes_test_task/features/recipes/screens/recipes_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Провайдер GoRouter с аннотацией Riverpod
@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'recipeList',
        builder: (context, state) => const RecipesScreen(),
      ),
      GoRoute(
        path: '/recipe',
        name: 'recipeDetail',
        builder: (context, state) {
          final recipeId = state.extra as String;
          return RecipeDetailScreen(recipeId: recipeId);
        },
      ),
    ],
  );
}
