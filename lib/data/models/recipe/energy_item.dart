import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_test_task/core/utils/annotations.dart';

part 'energy_item.g.dart';

@responseModel
class EnergyItem {
  EnergyItem({
    required this.title,
    required this.text,
  });

  factory EnergyItem.fromJson(Map<String, dynamic> json) => _$EnergyItemFromJson(json);

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'text')
  final String text;
}
