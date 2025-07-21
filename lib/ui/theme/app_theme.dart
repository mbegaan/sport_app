import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_dimensions.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.black,
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: AppTypography.fontFamily,
    
    // Palette noir et blanc strict - design radical minimal
    colorScheme: const ColorScheme.light(
      primary: AppColors.black,
      secondary: AppColors.black,
      surface: AppColors.white,
      background: AppColors.white,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.black,
      onBackground: AppColors.black,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
      centerTitle: true,
    ),
    
    textTheme: const TextTheme(
      // Système de tailles proportionnelles uniforme avec Roboto
      bodyLarge: TextStyle(fontSize: 20, height: 1.4, fontFamily: AppTypography.fontFamily, fontWeight: AppTypography.regular),
      bodyMedium: TextStyle(fontSize: 18, height: 1.4, fontFamily: AppTypography.fontFamily, fontWeight: AppTypography.regular),
      bodySmall: TextStyle(fontSize: 16, height: 1.4, fontFamily: AppTypography.fontFamily, fontWeight: AppTypography.regular),
      headlineLarge: TextStyle(fontSize: 40, fontWeight: AppTypography.light, height: 1.2, fontFamily: AppTypography.fontFamily),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: AppTypography.light, height: 1.2, fontFamily: AppTypography.fontFamily),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: AppTypography.light, height: 1.2, fontFamily: AppTypography.fontFamily),
      titleLarge: TextStyle(fontSize: 18, fontWeight: AppTypography.medium, height: 1.3, fontFamily: AppTypography.fontFamily),
      titleMedium: TextStyle(fontSize: 16, fontWeight: AppTypography.medium, height: 1.3, fontFamily: AppTypography.fontFamily),
      titleSmall: TextStyle(fontSize: 14, fontWeight: AppTypography.medium, height: 1.3, fontFamily: AppTypography.fontFamily),
      // Styles spécialisés pour l'app
      displayLarge: TextStyle(fontSize: 60, fontWeight: AppTypography.light, fontFamily: AppTypography.fontFamily), // Compteur reps
      displayMedium: TextStyle(fontSize: 18, fontWeight: AppTypography.medium, fontFamily: AppTypography.fontFamily), // Boutons principaux
      displaySmall: TextStyle(fontSize: 12, fontWeight: AppTypography.medium, fontFamily: AppTypography.fontFamily), // Fractions exercices
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, AppDimensions.buttonHeight),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.mainPadding + AppSpacing.gapS, 
          vertical: AppSpacing.gapM
        ),
        textStyle: AppTextStyles.button,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        elevation: 0,
      ),
    ),
    
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.buttonRadius)),
        side: const BorderSide(color: AppColors.black, width: 1),
      ),
    ),
  );
}
