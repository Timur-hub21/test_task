import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_test_task/core/utils/annotations.dart';
import 'package:recipes_test_task/data/models/recipe/recipe.dart';

part 'recipe_response.g.dart';

@responseModel
class RecipeResponse {
  RecipeResponse({
    required this.recepts,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) => _$RecipeResponseFromJson(json);

  @JsonKey(name: 'news')
  final List<Recipe> recepts;
}
