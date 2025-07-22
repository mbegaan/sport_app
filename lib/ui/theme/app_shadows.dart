/// Système d'ombres et d'élévations centralisé pour l'app
import 'package:flutter/material.dart';

class AppShadows {
  // === OMBRES DE BASE ===
  // Ombres subtiles pour design minimal
  static const BoxShadow none = BoxShadow(
    color: Colors.transparent,
    blurRadius: 0,
    offset: Offset.zero,
  );
  
  static const BoxShadow subtle = BoxShadow(
    color: Color(0x08000000), // Noir 3% opacité
    blurRadius: 4,
    offset: Offset(0, 2),
  );
  
  static const BoxShadow soft = BoxShadow(
    color: Color(0x10000000), // Noir 6% opacité
    blurRadius: 8,
    offset: Offset(0, 4),
  );
  
  static const BoxShadow medium = BoxShadow(
    color: Color(0x15000000), // Noir 8% opacité
    blurRadius: 16,
    offset: Offset(0, 8),
  );
  
  // === OMBRES SPÉCIALISÉES ===
  // Pour éléments flottants et modales
  static const BoxShadow floating = BoxShadow(
    color: Color(0x20000000), // Noir 12% opacité
    blurRadius: 24,
    offset: Offset(0, 12),
  );
  
  static const BoxShadow modal = BoxShadow(
    color: Color(0x30000000), // Noir 18% opacité
    blurRadius: 32,
    offset: Offset(0, 16),
  );
  
  // === OMBRES COLORÉES ===
  // Pour effets spéciaux (usage rare)
  static const BoxShadow successGlow = BoxShadow(
    color: Color(0x20059669), // Vert success avec opacité
    blurRadius: 12,
    offset: Offset(0, 4),
  );
  
  static const BoxShadow errorGlow = BoxShadow(
    color: Color(0x20DC2626), // Rouge error avec opacité
    blurRadius: 12,
    offset: Offset(0, 4),
  );
  
  // === LISTES D'OMBRES ===
  // Combinaisons d'ombres pour effets complexes
  static const List<BoxShadow> cardShadow = [subtle];
  static const List<BoxShadow> buttonShadow = [none]; // Design minimal sans ombres
  static const List<BoxShadow> floatingButtonShadow = [floating];
  static const List<BoxShadow> modalShadow = [modal];
  
  // === ÉLÉVATIONS MATERIAL ===
  // Correspondance avec Material Design
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation3 = 3.0;
  static const double elevation4 = 4.0;
  static const double elevation6 = 6.0;
  static const double elevation8 = 8.0;
  static const double elevation12 = 12.0;
  static const double elevation16 = 16.0;
  static const double elevation24 = 24.0;
  
  // === MÉTHODES UTILITAIRES ===
  
  /// Retourne une ombre adaptée au niveau d'élévation
  static List<BoxShadow> forElevation(double elevation) {
    if (elevation <= 0) return [none];
    if (elevation <= 2) return [subtle];
    if (elevation <= 4) return [soft];
    if (elevation <= 8) return [medium];
    if (elevation <= 16) return [floating];
    return [modal];
  }
  
  /// Retourne une ombre responsive selon la taille d'écran
  static List<BoxShadow> responsiveShadow(double screenWidth) {
    // Sur mobile, ombres plus subtiles pour économiser la batterie
    if (screenWidth < 600) return [subtle];
    // Sur desktop, ombres plus prononcées pour la hiérarchie
    return [soft];
  }
}
