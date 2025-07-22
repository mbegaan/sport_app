/// Palette centrale pour l'app, extensible à terme.
import 'package:flutter/material.dart';

class AppColors {
  // === COULEURS PRINCIPALES ===
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF6B7280);
  
  // === COULEURS SÉMANTIQUES (futures extensions) ===
  // Couleurs d'état pour futures fonctionnalités
  static const Color success = Color(0xFF10B981);  // Vert pour validation/succès
  static const Color warning = Color(0xFFF59E0B);  // Orange pour attention
  static const Color error = Color(0xFFEF4444);    // Rouge pour erreurs
  static const Color info = Color(0xFF3B82F6);     // Bleu pour informations
  
  // === COULEURS SURFACE (variants) ===
  // Nuances pour futures surfaces complexes
  static const Color greyLight = Color(0xFFF3F4F6);   // Gris très clair
  static const Color greyDark = Color(0xFF374151);    // Gris foncé
  
  // === COULEURS ACCENT (futures palettes) ===
  // Placeholder pour thèmes alternatifs
  static const Color accentPrimary = black;    // Alias pour cohérence
  static const Color accentSecondary = grey;   // Alias pour cohérence
}
