import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_test_task/core/utils/annotations.dart';

part 'step_item.g.dart';

@responseModel
class StepItem {
  StepItem({
    required this.text,
    required this.image1,
    required this.image2,
  });

  factory StepItem.fromJson(Map<String, dynamic> json) => _$StepItemFromJson(json);

  @JsonKey(name: 'text')
  final String text;

  @JsonKey(name: 'image1', fromJson: _emptyToNull)
  final String? image1;

  @JsonKey(name: 'image2', fromJson: _emptyToNull)
  final String? image2;

  static String? _emptyToNull(String? value) {
    if (value == null || value.isEmpty) return null;
    return value;
  }
}
