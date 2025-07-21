import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_dimensions.dart';

/// Widget pour afficher le compteur de répétitions avec style uniforme
class RepCounter extends StatelessWidget {
  final int count;

  const RepCounter({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.repCounterPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.buttonRadius * 2),
      ),
      child: Text(
        '$count',
        style: AppTextStyles.repCounter.copyWith(
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
