import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_test_task/data/models/recipe/recipe.dart';
import 'package:recipes_test_task/features/recipes/screens/recipe_detail_screen.dart';
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
        path: '/recipe/:id',
        name: 'recipeDetail',
        builder: (context, state) {
          final String recipeId = state.pathParameters['id'] ?? '0';
          final Recipe recipe = state.extra as Recipe;
          return RecipeDetailScreen(
            recipeId: recipeId,
            recipe: recipe,
          );
        },
      ),
    ],
  );
}
