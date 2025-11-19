import 'package:fpdart/fpdart.dart';
import 'package:recipes_test_task/app/di/di.dart';
import 'package:recipes_test_task/core/utils/either_extension.dart';
import 'package:recipes_test_task/data/local/recipes_local_data_source.dart';
import 'package:recipes_test_task/data/models/recipe/recipe.dart';
import 'package:recipes_test_task/data/models/recipe/recipe_response.dart';
import 'package:recipes_test_task/data/repository/recipes_repository.dart';
import 'package:recipes_test_task/domain/errors/app_exception.dart';
import 'package:recipes_test_task/features/recipes/provider/recipes_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipes_notifier.g.dart';

@riverpod
class RecipesNotifier extends _$RecipesNotifier {
  late RecipesRepository _recipesRepository;
  late RecipesLocalDataSource _recipesLocalDataSource;

  @override
  RecipesState build() {
    ref.keepAlive();
    _recipesRepository = ref.read(recipesRepositoryProvider);
    _recipesLocalDataSource = ref.watch(recipesLocalDataSourceProvider);

    Future(getRecipes);

    return RecipesState.initialize();
  }

  Future<void> getRecipes({bool needLoadingState = false}) async {
    if (needLoadingState && !state.isLoading) {
      state = state.copyWith(isLoading: true);
    }

    final (
      AppException? appException,
      Option<RecipeResponse> response,
    ) = (await _recipesRepository.getRecipes().run())
        .toRecord();

    if (appException != null) {
      state = state.copyWith(isLoading: false, errorMessage: appException.toString());
      return;
    }

    final List<Recipe> allRecepts = response.toNullable()?.recepts ?? <Recipe>[];
    final List<Recipe> initialVisible = allRecepts.take(10).toList();

    state = state.copyWith(recepts: allRecepts, visibleRecepts: initialVisible, isLoading: false);

    _recipesLocalDataSource.insertOrUpdateRecipes(allRecepts);
  }

  void loadMore() {
    final int alreadyVisible = state.visibleRecepts.length;
    if (alreadyVisible >= state.recepts.length) return;

    final List<Recipe> nextBatch = state.recepts.skip(alreadyVisible).take(10).toList();

    state = state.copyWith(
      visibleRecepts: <Recipe>[...state.visibleRecepts, ...nextBatch],
    );
  }
}
