/// Tokens d'animation centralisés pour l'app
import 'package:flutter/material.dart';

class AppAnimations {
  // === DURÉES DE BASE ===
  static const Duration fadeShort = Duration(milliseconds: 200);
  static const Duration fadeMedium = Duration(milliseconds: 400);
  static const Duration slideShort = Duration(milliseconds: 250);
  static const Duration slideMedium = Duration(milliseconds: 500);

  // === COURBES DE BASE ===
  static const Curve ease = Curves.easeInOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  
  // === DURÉES ÉTENDUES ===
  // Pour interfaces plus complexes
  static const Duration fadeLong = Duration(milliseconds: 600);
  static const Duration slideLong = Duration(milliseconds: 750);
  static const Duration scaleDuration = Duration(milliseconds: 300);
  static const Duration rotateDuration = Duration(milliseconds: 500);
  
  // === DURÉES SPÉCIALISÉES ===
  // Pour fonctionnalités métier spécifiques
  static const Duration timerTick = Duration(milliseconds: 100);
  static const Duration breathingCycle = Duration(seconds: 4);
  static const Duration effortAnimation = Duration(milliseconds: 800);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 3);
  
  // === COURBES ÉTENDUES ===
  // Courbes spécialisées pour différents effets
  static const Curve bounceIn = Curves.elasticOut;
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve sharp = Curves.easeInOutQuart;
  static const Curve gentle = Curves.easeInOutSine;
  
  // === COURBES PERSONNALISÉES ===
  // Pour effets spécifiques à l'app fitness
  static const Curve breathingCurve = Curves.easeInOutSine;  // Respiration naturelle
  static const Curve effortCurve = Curves.easeInQuart;       // Effort progressif
  static const Curve recoveryCurve = Curves.easeOutCubic;    // Récupération
}
