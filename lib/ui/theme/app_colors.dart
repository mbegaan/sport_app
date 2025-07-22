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
  
  // === VARIANTES DE COULEURS (nouveaux tokens) ===
  // Pour composants avec états multiples
  static const Color primaryHover = Color(0xFF1F1F1F);    // Noir légèrement plus clair pour hover
  static const Color primaryPressed = Color(0xFF0A0A0A);  // Noir plus foncé pour pressed
  static const Color primaryDisabled = Color(0xFF9CA3AF); // Gris pour disabled
  
  // Variantes de surface
  static const Color surfaceElevated = Color(0xFFFAFAFA);  // Surface légèrement élevée
  static const Color surfacePressed = Color(0xFFE5E7EB);   // Surface enfoncée
  
  // Couleurs transparentes pour overlays
  static const Color overlayLight = Color(0x0F000000);     // Overlay subtil (6% noir)
  static const Color overlayMedium = Color(0x1A000000);    // Overlay moyen (10% noir)
  static const Color overlayDark = Color(0x33000000);      // Overlay foncé (20% noir)
  
  // === COULEURS SPÉCIALISÉES ===
  // Pour composants spécifiques de l'app
  static const Color timerActive = success;      // Couleur timer en cours
  static const Color timerPaused = warning;     // Couleur timer en pause
  static const Color timerCompleted = black;    // Couleur timer terminé
  
  static const Color repCounterBackground = white;  // Background compteur
  static const Color repCounterText = black;        // Texte compteur
  
  static const Color progressActive = black;     // Progression active
  static const Color progressInactive = grey;    // Progression inactive
}
