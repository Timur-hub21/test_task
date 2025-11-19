import 'package:recipes_test_task/data/models/recipe/recipe.dart';

final class RecipesState {
  final bool isLoading;
  final List<Recipe> recepts;
  final List<Recipe> visibleRecepts;
  final String? errorMessage;

  const RecipesState({
    required this.isLoading,
    required this.recepts,
    required this.visibleRecepts,

    this.errorMessage,
  });

  factory RecipesState.initialize() => const RecipesState(
    isLoading: true,
    visibleRecepts: <Recipe>[],
    recepts: <Recipe>[],
  );

  RecipesState copyWith({
    bool? isLoading,
    List<Recipe>? recepts,
    List<Recipe>? visibleRecepts,
    String? errorMessage,
  }) {
    return RecipesState(
      isLoading: isLoading ?? this.isLoading,
      recepts: recepts ?? this.recepts,
      visibleRecepts: visibleRecepts ?? this.visibleRecepts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
