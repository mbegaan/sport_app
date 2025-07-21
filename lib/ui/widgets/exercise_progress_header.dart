import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_spacing.dart';

/// Widget pour l'en-tête avec progression d'exercice (fractions + nom)
class ExerciseProgressHeader extends StatelessWidget {
  final int currentExerciseIndex;
  final int totalExercises;
  final String exerciseName;
  final int currentSet;
  final int totalSets;

  const ExerciseProgressHeader({
    super.key,
    required this.currentExerciseIndex,
    required this.totalExercises,
    required this.exerciseName,
    required this.currentSet,
    required this.totalSets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mainPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Fraction exercice
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.progressDotPaddingHorizontal, 
              vertical: AppDimensions.progressDotPaddingVertical
            ),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
            child: Text(
              '${currentExerciseIndex + 1}/$totalExercises',
              style: AppTextStyles.exerciseFraction,
            ),
          ),
          SizedBox(width: AppSpacing.gapM),
          // Nom de l'exercice
          Expanded(
            child: Text(
              exerciseName,
              style: AppTextStyles.exerciseTitle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: AppSpacing.gapM),
          // Fraction série
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.progressDotPaddingHorizontal, 
              vertical: AppDimensions.progressDotPaddingVertical
            ),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
            child: Text(
              '$currentSet/$totalSets',
              style: AppTextStyles.exerciseFraction,
            ),
          ),
        ],
      ),
    );
  }
}
