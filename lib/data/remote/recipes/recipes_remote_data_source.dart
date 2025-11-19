import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:recipes_test_task/data/models/recipe/recipe_response.dart';
import 'package:recipes_test_task/data/remote/recipes/recipes_api_client.dart';

import 'package:recipes_test_task/domain/errors/app_exception.dart';
import 'package:recipes_test_task/domain/errors/errors.dart';

abstract interface class RecipesRemoteDataSource {
  TaskEither<AppException, RecipeResponse> getRecipes();
}

class RecipesRemoteDataSourceImpl implements RecipesRemoteDataSource {
  final RecipesApiClient recipesApiClient;

  RecipesRemoteDataSourceImpl({required Dio dio}) : recipesApiClient = RecipesApiClient(dio);

  @override
  TaskEither<AppException, RecipeResponse> getRecipes() => TaskEither.tryCatch(
    () async {
      try {
        final RecipeResponse response = await recipesApiClient.getRecipes();
        return response;
      } on DioException catch (dioErr) {
        throw AppException.wrap(dioErr, dioErr.stackTrace);
      } on TypeError catch (_) {
        throw AppException.wrap(
          UnknownError("Ошибка обработки данных с сервера"),
          StackTrace.current,
        );
      } catch (e) {
        throw AppException.wrap(e, StackTrace.current);
      }
    },
    AppException.wrap,
  );
}
