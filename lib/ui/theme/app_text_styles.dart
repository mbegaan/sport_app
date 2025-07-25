
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';

class AppTextStyles {
  // Styles basés sur le TextTheme de Flutter (responsive par défaut)
  
  /// Style pour les titres d'exercice - basé sur titleSmall
  static TextStyle exerciseTitleContext(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
      fontWeight: AppTypography.light,
      color: AppColors.black,
      fontFamily: AppTypography.fontFamily,
    );
  }

  /// Style pour les fractions d'exercice - basé sur labelMedium
  static TextStyle exerciseFractionContext(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontWeight: AppTypography.medium,
      color: AppColors.white,
      fontFamily: AppTypography.fontFamily,
    );
  }

  /// Style pour les détails d'exercice - basé sur bodySmall
  static TextStyle exerciseDetailsContext(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      fontWeight: AppTypography.regular,
      color: AppColors.grey,
      fontFamily: AppTypography.fontFamily,
    );
  }

  /// Style pour les boutons - basé sur labelLarge
  static TextStyle buttonContext(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontWeight: AppTypography.medium,
      color: AppColors.white,
      fontFamily: AppTypography.fontFamily,
    );
  }

  // === STYLES RESPONSIFS (maintenant basés sur TextTheme) ===
  
  /// Style responsive pour les titres d'exercice
  static TextStyle exerciseTitleResponsive(BuildContext context, double screenWidth) {
    final baseStyle = AppTextStyles.exerciseTitleContext(context);
    if (AppDimensions.isSmallScreen(screenWidth)) {
      return baseStyle; // Taille normale pour mobile
    } else if (AppDimensions.isMediumScreen(screenWidth)) {
      return baseStyle.copyWith(fontSize: baseStyle.fontSize! * 1.33); // Plus grand pour tablet
    } else {
      return baseStyle.copyWith(fontSize: baseStyle.fontSize! * 1.67); // Encore plus grand pour desktop
    }
  }
  
  /// Style responsive pour les textes de bouton selon la taille d'écran
  static TextStyle buttonResponsive(BuildContext context, double screenWidth) {
    final baseStyle = AppTextStyles.buttonContext(context);
    if (AppDimensions.isSmallScreen(screenWidth)) {
      return baseStyle; // Taille normale pour mobile
    } else {
      return baseStyle.copyWith(fontSize: baseStyle.fontSize! * 0.89); // Plus petit pour tablet/desktop
    }
  }
  
  /// Style responsive pour les compteurs de répétitions
  static TextStyle repCounterResponsive(BuildContext context, double screenWidth) {
    final baseStyle = AppTextStyles.repCounterContext(context);
    if (AppDimensions.isSmallScreen(screenWidth)) {
      return baseStyle; // Taille normale pour mobile
    } else if (AppDimensions.isMediumScreen(screenWidth)) {
      return baseStyle.copyWith(fontSize: baseStyle.fontSize! * 1.33); // Plus grand pour tablet
    } else {
      return baseStyle.copyWith(fontSize: baseStyle.fontSize! * 1.67); // Encore plus grand pour desktop
    }
  }

  // === STYLES FIXES (basés sur TextTheme pour compatibilité) ===
  
  /// Style pour les titres de completion - basé sur headlineMedium
  static TextStyle completionTitleContext(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontWeight: AppTypography.light,
      color: AppColors.white,
      fontFamily: AppTypography.fontFamily,
    );
  }

  /// Style pour les sous-titres de completion - basé sur titleMedium
  static TextStyle completionSubtitleContext(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: AppTypography.regular,
      color: AppColors.white,
      fontFamily: AppTypography.fontFamily,
    );
  }

  /// Style pour les messages d'erreur - basé sur titleLarge
  static TextStyle errorMessageContext(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontWeight: AppTypography.regular,
      color: AppColors.black,
      fontFamily: AppTypography.fontFamily,
    );
  }

  /// Style pour le compteur de reps (gros chiffre central) - basé sur displayLarge
  static TextStyle repCounterContext(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge!.copyWith(
      fontWeight: AppTypography.light,
      color: AppColors.black,
      fontFamily: AppTypography.fontFamily,
    );
  }
  
  // === STYLES ÉTENDUS (basés sur TextTheme) ===
  
  /// Style pour les éléments de navigation - basé sur labelMedium
  static TextStyle navigationItem(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontWeight: AppTypography.medium,
      color: AppColors.black,
      fontFamily: AppTypography.fontFamily,
    );
  }
  
  /// Style pour les titres de page - basé sur headlineMedium
  static TextStyle pageTitle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontWeight: AppTypography.light,
      color: AppColors.black,
      fontFamily: AppTypography.fontFamily,
    );
  }
  
  /// Style pour les en-têtes de section - basé sur titleMedium
  static TextStyle sectionHeader(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: AppTypography.medium,
      color: AppColors.black,
      fontFamily: AppTypography.fontFamily,
    );
  }
  
  // === STYLES POUR ÉTATS ET FEEDBACK ===
  
  /// Style pour les messages de succès
  static TextStyle successMessage(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: AppTypography.regular,
      color: AppColors.success,
      fontFamily: AppTypography.fontFamily,
    );
  }
  
  /// Style pour les messages d'avertissement
  static TextStyle warningMessage(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: AppTypography.regular,
      color: AppColors.warning,
      fontFamily: AppTypography.fontFamily,
    );
  }
  
  /// Style pour les messages d'information
  static TextStyle infoMessage(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: AppTypography.regular,
      color: AppColors.info,
      fontFamily: AppTypography.fontFamily,
    );
  }
  
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
  
  // === VERSIONS STATIQUES POUR COMPATIBILITÉ ===
  // À utiliser uniquement quand le BuildContext n'est pas disponible
  
  static const exerciseTitleStatic = TextStyle(
    fontSize: 14.0, // Équivalent à titleSmall par défaut
    fontWeight: AppTypography.light,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );

  static const exerciseFractionStatic = TextStyle(
    fontSize: 12.0, // Équivalent à labelMedium par défaut
    fontWeight: AppTypography.medium,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );

  static const buttonStatic = TextStyle(
    fontSize: 14.0, // Équivalent à labelLarge par défaut
    fontWeight: AppTypography.medium,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );

  static const repCounterStatic = TextStyle(
    fontSize: 57.0, // Équivalent à displayLarge par défaut
    fontWeight: AppTypography.light,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  // === GETTERS POUR COMPATIBILITÉ ARRIÈRE ===
  // Utilisent les versions statiques quand le context n'est pas disponible
  
  static TextStyle get exerciseTitle => exerciseTitleStatic;
  static TextStyle get exerciseFraction => exerciseFractionStatic;
  static TextStyle get exerciseDetails => const TextStyle(
    fontSize: 12.0,
    fontWeight: AppTypography.regular,
    color: AppColors.grey,
    fontFamily: AppTypography.fontFamily,
  );
  static TextStyle get button => buttonStatic;
  static TextStyle get repCounter => repCounterStatic;
  static TextStyle get completionTitle => const TextStyle(
    fontSize: 24.0,
    fontWeight: AppTypography.light,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );
  static TextStyle get completionSubtitle => const TextStyle(
    fontSize: 16.0,
    fontWeight: AppTypography.regular,
    color: AppColors.white,
    fontFamily: AppTypography.fontFamily,
  );
  static TextStyle get errorMessage => const TextStyle(
    fontSize: 20.0,
    fontWeight: AppTypography.regular,
    color: AppColors.black,
    fontFamily: AppTypography.fontFamily,
  );
  
  // === LEGACY GETTERS (pour migration progressive) ===
  // Ces getters permettent de maintenir la compatibilité pendant la migration
  
  @Deprecated('Utilisez exerciseTitleContext(context) à la place')
  static TextStyle get exerciseTitleLegacy => exerciseTitleStatic;
  
  @Deprecated('Utilisez exerciseFractionContext(context) à la place')
  static TextStyle get exerciseFractionLegacy => exerciseFractionStatic;
  
  @Deprecated('Utilisez buttonContext(context) à la place')
  static TextStyle get buttonLegacy => buttonStatic;
  
  @Deprecated('Utilisez repCounterContext(context) à la place')
  static TextStyle get repCounterLegacy => repCounterStatic;
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
