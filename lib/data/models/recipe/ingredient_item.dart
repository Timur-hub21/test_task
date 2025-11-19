import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_test_task/core/utils/annotations.dart';

part 'ingredient_item.g.dart';

@responseModel
class IngredientItem {
  IngredientItem({
    required this.title,
    required this.text,
  });

  factory IngredientItem.fromJson(Map<String, dynamic> json) => _$IngredientItemFromJson(json);

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'text')
  final String text;
}
