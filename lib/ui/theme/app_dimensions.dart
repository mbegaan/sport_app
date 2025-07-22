/// Dimensions et espacements centralisés pour l'app.
import 'app_spacing.dart';

class AppDimensions {
  // === BREAKPOINTS RESPONSIVE ===
  static const double smallScreenWidth = 600.0;
  static const double mediumScreenWidth = 900.0;
  static const double largeScreenWidth = 1200.0;
  
  // === MÉTHODES RESPONSIVE ===
  
  /// Détecte si l'écran est petit (mobile portrait)
  static bool isSmallScreen(double width) => width < smallScreenWidth;
  
  /// Détecte si l'écran est moyen (tablet, mobile landscape)
  static bool isMediumScreen(double width) => 
    width >= smallScreenWidth && width < mediumScreenWidth;
  
  /// Détecte si l'écran est large (desktop, large tablet)
  static bool isLargeScreen(double width) => width >= mediumScreenWidth;
  
  /// Retourne un padding adaptatif selon la taille d'écran
  static double paddingResponsive(double screenWidth) {
    if (isSmallScreen(screenWidth)) {
      return mainPadding; // 24px pour mobile
    } else if (isMediumScreen(screenWidth)) {
      return mainPadding * 1.5; // 36px pour tablet
    } else {
      return mainPadding * 2.0; // 48px pour desktop
    }
  }
  
  /// Retourne une hauteur de bouton adaptative
  static double buttonHeightResponsive(double screenWidth) {
    if (isSmallScreen(screenWidth)) {
      return buttonHeight; // 60px pour mobile
    } else {
      return buttonHeight * 0.8; // 48px pour tablet/desktop (plus dense)
    }
  }
  
  /// Retourne une taille de police adaptative pour les titres d'exercice
  static double exerciseTitleFontSizeResponsive(double screenWidth) {
    if (isSmallScreen(screenWidth)) {
      return exerciseTitleFontSize; // 12px pour mobile
    } else if (isMediumScreen(screenWidth)) {
      return exerciseTitleFontSize * 1.33; // 16px pour tablet
    } else {
      return exerciseTitleFontSize * 1.67; // 20px pour desktop
    }
  }
  
  /// Retourne un espacement de section adaptatif
  static double sectionSpacingResponsive(double screenWidth) {
    if (isSmallScreen(screenWidth)) {
      return sectionSpacing; // 40px pour mobile
    } else {
      return sectionSpacing * 1.5; // 60px pour tablet/desktop
    }
  }
  
  // === TAILLES FIXES (pour compatibilité) ===
  // Tailles de police
  static const double exerciseTitleFontSize = 12.0;
  static const double exerciseFractionFontSize = 12.0;
  
  // Espacements principaux
  static const double mainPadding = 24.0;
  static const double sectionSpacing = 40.0;
  
  // Composants
  static const double buttonHeight = 60.0;
  static const double buttonRadius = 16.0;
  
  // Padding pour les puces de progression
  static const double progressDotPaddingHorizontal = 12.0;
  static const double progressDotPaddingVertical = 6.0;
  
  // Padding pour le compteur de reps
  static const double repCounterPadding = 40.0;
  
  // Tailles d'icônes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 32.0;
  static const double iconSizeLarge = 100.0;
  
  // Épaisseurs de traits/bordures
  static const double strokeWidth = 3.0;
  static const double borderWidth = 1.0;
  
  // Largeurs de composants spécifiques
  static const double startButtonWidth = 200.0;
  
  // === DIMENSIONS ÉTENDUES (pour futures fonctionnalités) ===
  
  // Tailles d'avatar et profils
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 64.0;
  static const double avatarSizeLarge = 96.0;
  
  // Dimensions pour cartes et conteneurs
  static const double cardMinHeight = 120.0;
  static const double cardMaxWidth = 400.0;
  
  // Éléments d'interface avancés
  static const double floatingActionButtonSize = 56.0;
  static const double bottomNavHeight = 60.0;
  static const double appBarHeight = 56.0;
  
  // Bordures et séparateurs
  static const double dividerThickness = 1.0;
  static const double cardElevation = 2.0;
  
  // Dimensions responsive étendues
  static double cardPaddingResponsive(double screenWidth) {
    if (isSmallScreen(screenWidth)) {
      return AppSpacing.gapM; // 16px pour mobile
    } else {
      return AppSpacing.gapL; // 24px pour tablet/desktop
    }
  }
  
  static double avatarSizeResponsive(double screenWidth) {
    if (isSmallScreen(screenWidth)) {
      return avatarSizeMedium; // 64px pour mobile
    } else {
      return avatarSizeLarge; // 96px pour tablet/desktop
    }
  }
}
