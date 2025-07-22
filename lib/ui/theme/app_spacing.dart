/// Espacements standardisés pour l'app
import 'package:flutter/material.dart';

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
  
  // === HELPERS EDGEINSETS (nouveaux) ===
  // Pour éviter les EdgeInsets en dur dans les widgets
  
  /// Padding uniforme avec token
  static EdgeInsets all(double value) => EdgeInsets.all(value);
  static EdgeInsets allXS() => EdgeInsets.all(gapXS);
  static EdgeInsets allS() => EdgeInsets.all(gapS);
  static EdgeInsets allM() => EdgeInsets.all(gapM);
  static EdgeInsets allL() => EdgeInsets.all(gapL);
  static EdgeInsets allXL() => EdgeInsets.all(gapXL);
  
  /// Padding horizontal avec tokens
  static EdgeInsets horizontalS() => EdgeInsets.symmetric(horizontal: gapS);
  static EdgeInsets horizontalM() => EdgeInsets.symmetric(horizontal: gapM);
  static EdgeInsets horizontalL() => EdgeInsets.symmetric(horizontal: gapL);
  static EdgeInsets horizontalXL() => EdgeInsets.symmetric(horizontal: gapXL);
  
  /// Padding vertical avec tokens
  static EdgeInsets verticalS() => EdgeInsets.symmetric(vertical: gapS);
  static EdgeInsets verticalM() => EdgeInsets.symmetric(vertical: gapM);
  static EdgeInsets verticalL() => EdgeInsets.symmetric(vertical: gapL);
  static EdgeInsets verticalXL() => EdgeInsets.symmetric(vertical: gapXL);
  
  /// Padding directionnel (seulement bottom pour les listes)
  static EdgeInsets bottomS() => EdgeInsets.only(bottom: gapS);
  static EdgeInsets bottomM() => EdgeInsets.only(bottom: gapM);
  static EdgeInsets bottomL() => EdgeInsets.only(bottom: gapL);
  static EdgeInsets bottomXL() => EdgeInsets.only(bottom: gapXL);
  
  /// Combinaisons courantes
  static EdgeInsets listItem() => EdgeInsets.only(bottom: itemGap);
  static EdgeInsets formField() => EdgeInsets.only(bottom: formSpacing);
  static EdgeInsets card() => EdgeInsets.all(cardSpacing);
}
