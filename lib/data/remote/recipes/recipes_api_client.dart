import 'package:dio/dio.dart';
import 'package:recipes_test_task/data/models/recipe/recipe_response.dart';
import 'package:retrofit/retrofit.dart';

part 'recipes_api_client.g.dart';

@RestApi()
abstract class RecipesApiClient {
  factory RecipesApiClient(
    Dio dio, {
    String baseUrl,
  }) = _RecipesApiClient;

  @GET('/index.php?route=api/app/getRecipes')
  Future<RecipeResponse> getRecipes();
}
