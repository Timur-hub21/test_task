import 'package:fpdart/fpdart.dart';
import 'package:recipes_test_task/data/models/recipe/recipe_response.dart';
import 'package:recipes_test_task/data/remote/recipes/recipes_remote_data_source.dart';
import 'package:recipes_test_task/domain/errors/app_exception.dart';
import 'package:recipes_test_task/data/repository/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  final RecipesRemoteDataSource _recipesRemoteDataSource;

  RecipesRepositoryImpl({
    required RecipesRemoteDataSource recipesRemoteDataSource,
  }) : _recipesRemoteDataSource = recipesRemoteDataSource;

  @override
  TaskEither<AppException, RecipeResponse> getRecipes() {
    return _recipesRemoteDataSource.getRecipes();
  }
}
