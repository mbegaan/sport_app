
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';

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

  // === STYLES RESPONSIFS ===
  
  /// Style responsive pour les titres d'exercice
  static TextStyle exerciseTitleResponsive(double screenWidth) {
    return exerciseTitle.copyWith(
      fontSize: AppDimensions.exerciseTitleFontSizeResponsive(screenWidth),
    );
  }
  
  /// Style responsive pour les textes de bouton selon la taille d'écran
  static TextStyle buttonResponsive(double screenWidth) {
    if (AppDimensions.isSmallScreen(screenWidth)) {
      return button; // Taille normale pour mobile
    } else {
      return button.copyWith(fontSize: 16.0); // Plus petit pour tablet/desktop
    }
  }
  
  /// Style responsive pour les compteurs de répétitions
  static TextStyle repCounterResponsive(double screenWidth) {
    if (AppDimensions.isSmallScreen(screenWidth)) {
      return repCounter; // 60px pour mobile
    } else if (AppDimensions.isMediumScreen(screenWidth)) {
      return repCounter.copyWith(fontSize: 80.0); // Plus grand pour tablet
    } else {
      return repCounter.copyWith(fontSize: 100.0); // Encore plus grand pour desktop
    }
  }

  // === STYLES FIXES (pour compatibilité) ===
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
  
  // === STYLES ÉTENDUS (pour futures fonctionnalités) ===
  
  // Styles pour navigation et headers
  static const navigationItem = TextStyle(
    fontSize: 14.0,
    fontWeight: AppTypography.medium,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const pageTitle = TextStyle(
    fontSize: 28.0,
    fontWeight: AppTypography.light,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const sectionHeader = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.medium,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  // Styles pour états et feedback
  static const successMessage = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.regular,
    color: AppColors.success,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const warningMessage = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.regular,
    color: AppColors.warning,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const infoMessage = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.regular,
    color: AppColors.info,
    fontFamily: AppTypography.fontFamily,
  );
  
  // Styles pour formulaires et inputs
  static const inputLabel = TextStyle(
    fontSize: 14.0,
    fontWeight: AppTypography.medium,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const inputText = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.regular,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const inputPlaceholder = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.regular,
    color: AppColors.grey,
    fontFamily: AppTypography.fontFamily,
  );
  
  // Styles pour contenu riche
  static const caption = TextStyle(
    fontSize: 12.0,
    fontWeight: AppTypography.regular,
    color: AppColors.grey,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const metadata = TextStyle(
    fontSize: 11.0,
    fontWeight: AppTypography.regular,
    color: AppColors.grey,
    fontFamily: AppTypography.fontFamily,
  );
  
  // === VARIANTES DE BOUTONS (nouveaux) ===
  // Styles spécialisés pour différents types de boutons
  
  static const buttonPrimary = TextStyle(
    fontSize: 18.0,
    fontWeight: AppTypography.medium,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const buttonSecondary = TextStyle(
    fontSize: 18.0,
    fontWeight: AppTypography.medium,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const buttonSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: AppTypography.medium,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const buttonLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: AppTypography.medium,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const buttonDisabled = TextStyle(
    fontSize: 18.0,
    fontWeight: AppTypography.medium,
    color: AppColors.primaryDisabled,
    fontFamily: AppTypography.fontFamily,
  );
  
  // === STYLES ÉTAT (nouvelles variantes) ===
  // Pour feedbacks d'interaction
  
  static const textHover = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.medium,
    color: AppColors.primaryHover,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const textPressed = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.medium,
    color: AppColors.primaryPressed,
    fontFamily: AppTypography.fontFamily,
  );
  
  static const textSelected = TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.bold,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
}
