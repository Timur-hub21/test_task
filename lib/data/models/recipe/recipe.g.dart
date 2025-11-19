// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
  id: json['id'] as String,
  steps: (json['steps'] as List<dynamic>)
      .map((e) => StepItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  prepTime: json['prep_time'] as String,
  energy: (json['energy'] as List<dynamic>)
      .map((e) => EnergyItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  ingredientsOne: (json['ingredients_one'] as List<dynamic>)
      .map((e) => IngredientItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  ingredientsTwo: (json['ingredients_two'] as List<dynamic>)
      .map((e) => IngredientItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  image: json['image'] as String,
  title: json['title'] as String,
  text: json['text'] as String,
  dateAdded: json['date_added'] as String,
  link: Recipe._emptyToNull(json['link'] as String?),
);
