/// Espacements standardisés pour l'app
class AppSpacing {
  // === ESPACEMENTS DE BASE ===
  static const double gapXS = 4.0;
  static const double gapS = 8.0;
  static const double gapM = 16.0;
  static const double gapL = 24.0;
  static const double gapXL = 40.0;
  
  // === ESPACEMENTS ÉTENDUS ===
  // Pour interfaces plus complexes
  static const double gapXXL = 64.0;  // Très grand espacement
  static const double gapXXXL = 96.0; // Espacement maximum
  
  // === ESPACEMENTS SÉMANTIQUES ===
  // Espacements avec signification métier
  static const double sectionGap = gapXL;      // Entre sections principales
  static const double itemGap = gapM;          // Entre éléments de liste
  static const double inlineGap = gapS;        // Entre éléments inline
  static const double marginGap = gapL;        // Marges de conteneurs
  
  // === ESPACEMENTS SPÉCIFIQUES ===
  // Pour composants précis
  static const double buttonSpacing = gapM;    // Entre boutons
  static const double textSpacing = gapS;      // Entre lignes de texte
  static const double cardSpacing = gapL;      // Entre cartes
  static const double formSpacing = gapM;      // Entre champs de formulaire
}
