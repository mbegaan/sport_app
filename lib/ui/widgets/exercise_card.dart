import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_spacing.dart';
import '../theme/app_colors.dart';

class ExerciseCard extends StatelessWidget {
  final String name;
  final String details;
  final VoidCallback? onTap;

  const ExerciseCard({
    super.key,
    required this.name,
    required this.details,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.mainPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          border: Border.all(color: AppColors.black, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppTextStyles.exerciseTitle),
            const SizedBox(height: AppSpacing.gapS),
            Text(details, style: AppTextStyles.exerciseDetails),
          ],
        ),
      ),
    );
  }
}
