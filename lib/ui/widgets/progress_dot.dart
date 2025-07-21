import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_dimensions.dart';

class ProgressDot extends StatelessWidget {
  final String label;
  final bool isActive;

  const ProgressDot({
    super.key,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.progressDotPaddingHorizontal, 
        vertical: AppDimensions.progressDotPaddingVertical
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.black : AppColors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.exerciseFraction,
      ),
    );
  }
}
