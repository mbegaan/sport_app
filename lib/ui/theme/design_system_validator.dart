/// Helper pour validation et cohérence du design system
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_spacing.dart';
import 'app_animations.dart';

class DesignSystemValidator {
  /// Valide qu'une couleur utilise les tokens définis
  static bool isValidColor(Color color) {
    const validColors = [
      // Couleurs principales
      AppColors.black,
      AppColors.white,
      AppColors.grey,
      
      // Couleurs sémantiques
      AppColors.success,
      AppColors.warning,
      AppColors.error,
      AppColors.info,
      
      // Variantes de surface
      AppColors.greyLight,
      AppColors.greyDark,
      
      // Nouvelles variantes (extension Priorité 6)
      AppColors.primaryHover,
      AppColors.primaryPressed,
      AppColors.primaryDisabled,
      AppColors.surfaceElevated,
      AppColors.surfacePressed,
      AppColors.overlayLight,
      AppColors.overlayMedium,
      AppColors.overlayDark,
      
      // Couleurs spécialisées
      AppColors.timerActive,
      AppColors.timerPaused,
      AppColors.timerCompleted,
      AppColors.repCounterBackground,
      AppColors.repCounterText,
      AppColors.progressActive,
      AppColors.progressInactive,
    ];
    return validColors.contains(color);
  }
  
  /// Valide qu'un espacement utilise les tokens définis
  static bool isValidSpacing(double value) {
    const validSpacings = [
      AppSpacing.gapXS,
      AppSpacing.gapS,
      AppSpacing.gapM,
      AppSpacing.gapL,
      AppSpacing.gapXL,
      AppSpacing.gapXXL,
      AppSpacing.gapXXXL,
      AppDimensions.mainPadding,
      AppDimensions.sectionSpacing,
    ];
    return validSpacings.contains(value);
  }
  
  /// Valide qu'une durée d'animation utilise les tokens définis
  static bool isValidDuration(Duration duration) {
    const validDurations = [
      AppAnimations.fadeShort,
      AppAnimations.fadeMedium,
      AppAnimations.fadeLong,
      AppAnimations.slideShort,
      AppAnimations.slideMedium,
      AppAnimations.slideLong,
      AppAnimations.scaleDuration,
      AppAnimations.rotateDuration,
      AppAnimations.breathingCycle,
      AppAnimations.effortAnimation,
      AppAnimations.pageTransition,
      AppAnimations.snackBarDuration,
    ];
    return validDurations.contains(duration);
  }
  
  /// Retourne des recommandations pour remplacer des valeurs non-conformes
  static String getColorRecommendation(Color color) {
    if (color == Colors.black) return 'Utiliser AppColors.black';
    if (color == Colors.white) return 'Utiliser AppColors.white';
    if (color == Colors.grey || color == Colors.grey.shade500) return 'Utiliser AppColors.grey';
    if (color.red > 200 && color.green < 100 && color.blue < 100) return 'Utiliser AppColors.error pour les erreurs';
    if (color.green > 200 && color.red < 100 && color.blue < 100) return 'Utiliser AppColors.success pour les validations';
    return 'Ajouter cette couleur dans AppColors si nécessaire';
  }
  
  /// Trouve l'espacement le plus proche dans les tokens
  static double getNearestValidSpacing(double value) {
    const validSpacings = [
      AppSpacing.gapXS,    // 4
      AppSpacing.gapS,     // 8
      AppSpacing.gapM,     // 16
      AppSpacing.gapL,     // 24
      AppSpacing.gapXL,    // 40
      AppSpacing.gapXXL,   // 64
      AppSpacing.gapXXXL,  // 96
    ];
    
    double closest = validSpacings.first;
    double minDifference = (value - closest).abs();
    
    for (double spacing in validSpacings) {
      final difference = (value - spacing).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closest = spacing;
      }
    }
    
    return closest;
  }
  
  /// Génère un rapport de conformité pour un widget
  static Map<String, dynamic> analyzeWidget(Widget widget) {
    // Analyse basique - à étendre selon les besoins
    return {
      'type': widget.runtimeType.toString(),
      'conformsToDesignSystem': true, // À implémenter
      'recommendations': <String>[],
    };
  }
  
  /// Valide la hiérarchie typographique
  static bool isValidTypographyHierarchy(double fontSize1, double fontSize2) {
    // Vérifie que la différence de taille respecte les ratios harmonieux
    const validRatios = [1.125, 1.25, 1.333, 1.5, 1.618]; // Ratios typographiques classiques
    const tolerance = 0.1;
    
    if (fontSize1 == fontSize2) return true;
    
    final ratio = fontSize1 > fontSize2 ? fontSize1 / fontSize2 : fontSize2 / fontSize1;
    
    // Vérifie si le ratio correspond à un ratio valide avec une tolérance
    for (double validRatio in validRatios) {
      if ((ratio - validRatio).abs() <= tolerance) {
        return true;
      }
    }
    
    return false;
  }
  
  /// Valide le contraste entre deux couleurs
  static bool hasGoodContrast(Color foreground, Color background) {
    // Calcul de contraste WCAG simplifié
    final foregroundLuminance = foreground.computeLuminance();
    final backgroundLuminance = background.computeLuminance();
    
    final contrast = (foregroundLuminance + 0.05) / (backgroundLuminance + 0.05);
    final contrastRatio = contrast > 1 ? contrast : 1 / contrast;
    
    return contrastRatio >= 4.5; // Niveau AA WCAG
  }
}

/// Extension pour valider les widgets en debug
extension DesignSystemValidation on Widget {
  /// Vérifie la conformité du widget au design system
  Widget validateDesignSystem() {
    assert(() {
      // En mode debug, log les violations potentielles
      final analysis = DesignSystemValidator.analyzeWidget(this);
      if (analysis['recommendations'].isNotEmpty) {
        debugPrint('Design System Recommendations for ${analysis['type']}:');
        for (String recommendation in analysis['recommendations']) {
          debugPrint('  - $recommendation');
        }
      }
      return true;
    }());
    
    return this;
  }
}
