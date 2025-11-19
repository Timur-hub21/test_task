import 'package:fpdart/fpdart.dart';
import 'package:recipes_test_task/data/models/recipe/recipe_response.dart';
import 'package:recipes_test_task/domain/errors/app_exception.dart';

abstract interface class RecipesRepository {
  TaskEither<AppException, RecipeResponse> getRecipes();
}
