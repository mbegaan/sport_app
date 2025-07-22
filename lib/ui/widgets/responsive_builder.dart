import 'package:flutter/material.dart';
import '../theme/app_dimensions.dart';

/// Widget helper pour simplifier l'usage des dimensions responsives
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, double screenWidth) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return builder(context, screenWidth);
  }
}

/// Extension pour faciliter l'accès aux méthodes responsives
extension ResponsiveContext on BuildContext {
  /// Largeur de l'écran actuel
  double get screenWidth => MediaQuery.of(this).size.width;
  
  /// Hauteur de l'écran actuel
  double get screenHeight => MediaQuery.of(this).size.height;
  
  /// Vérifie si l'écran est petit
  bool get isSmallScreen => AppDimensions.isSmallScreen(screenWidth);
  
  /// Vérifie si l'écran est moyen
  bool get isMediumScreen => AppDimensions.isMediumScreen(screenWidth);
  
  /// Vérifie si l'écran est large
  bool get isLargeScreen => AppDimensions.isLargeScreen(screenWidth);
  
  /// Padding adaptatif
  double get responsivePadding => AppDimensions.paddingResponsive(screenWidth);
  
  /// Hauteur de bouton adaptative
  double get responsiveButtonHeight => AppDimensions.buttonHeightResponsive(screenWidth);
  
  /// Taille de police pour titre d'exercice adaptative
  double get responsiveExerciseTitleFontSize => 
    AppDimensions.exerciseTitleFontSizeResponsive(screenWidth);
  
  /// Espacement de section adaptatif
  double get responsiveSectionSpacing => 
    AppDimensions.sectionSpacingResponsive(screenWidth);
}
