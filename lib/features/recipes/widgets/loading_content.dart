import 'package:flutter/material.dart';
import 'package:recipes_test_task/core/themes/app_colors.dart';

class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(
      color: AppColors.primary,
      strokeWidth: 5,
    ),
  );
}
