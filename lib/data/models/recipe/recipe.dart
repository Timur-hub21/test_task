import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_test_task/core/utils/annotations.dart';
import 'step_item.dart';
import 'energy_item.dart';
import 'ingredient_item.dart';

part 'recipe.g.dart';

@responseModel
class Recipe {
  Recipe({
    required this.id,
    required this.steps,
    required this.prepTime,
    required this.energy,
    required this.ingredientsOne,
    required this.ingredientsTwo,
    required this.image,
    required this.title,
    required this.text,
    required this.dateAdded,
    required this.link,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'steps')
  final List<StepItem> steps;

  @JsonKey(name: 'prep_time')
  final String prepTime;

  @JsonKey(name: 'energy')
  final List<EnergyItem> energy;

  @JsonKey(name: 'ingredients_one')
  final List<IngredientItem> ingredientsOne;

  @JsonKey(name: 'ingredients_two')
  final List<IngredientItem> ingredientsTwo;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'text')
  final String text;

  @JsonKey(name: 'date_added')
  final String dateAdded;

  @JsonKey(name: 'link', fromJson: _emptyToNull)
  final String? link;

  static String? _emptyToNull(String? value) {
    if (value == null || value.isEmpty) return null;
    return value;
  }
}
