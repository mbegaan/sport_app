
import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

class AppTextStyles {
  // Styles spécialisés de l'app
  static const exerciseTitle = TextStyle(
    fontSize: AppDimensions.exerciseTitleFontSize,
    fontWeight: AppTypography.light,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );

  static const exerciseFraction = TextStyle(
    fontSize: AppDimensions.exerciseFractionFontSize,
    fontWeight: AppTypography.medium,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );

  static const exerciseDetails = TextStyle(
    fontSize: 12.0,
    fontWeight: AppTypography.regular,
    color: AppColors.grey,
    fontFamily: AppTypography.fontFamily,
  );

  static const button = TextStyle(
    fontSize: 18.0,
    fontWeight: AppTypography.medium,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );

  // Styles pour les textes de completion/félicitations
  static const completionTitle = TextStyle(
    fontSize: 24.0,
    fontWeight: AppTypography.light,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );

  static const completionSubtitle = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.regular,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );

  // Style pour les erreurs/messages
  static const errorMessage = TextStyle(
    fontSize: 20.0,
    fontWeight: AppTypography.regular,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );

  // Style pour le compteur de reps (gros chiffre central)
  static const repCounter = TextStyle(
    fontSize: 60.0,
    fontWeight: AppTypography.light,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
}
