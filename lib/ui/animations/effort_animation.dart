
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animation d'effort rythmée avec effet rebond à chaque seconde
/// Animation d'effort fluide et organique, inspirée de BreathingAnimation
class EffortAnimation extends StatelessWidget {
  final double progress; // 0.0 = début (80%), 1.0 = fin (0%)

  // Constantes pour l'effet rebond optionnel
  static const double minScale = 0.0; // Cercle invisible à la fin
  static const double maxScale = 0.8; // Cercle à 80% au début
  static const double reboundAmplitude = 0.04; // Amplitude du rebond (4%)
  static const double reboundFrequency = 1.0; // 1 rebond par seconde

  const EffortAnimation({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final minDimension = math.min(screenSize.width, screenSize.height);

    // Progress interpolé de façon douce (easeInOutCubic)
    final easedProgress = Curves.easeInOutCubic.transform(progress.clamp(0.0, 1.0));

    // Animation principale : cercle qui se réduit de maxScale à minScale
    double scale = maxScale * (1.0 - easedProgress);

    // Ajout d'un léger rebond organique synchronisé sur le temps (optionnel)
    if (progress < 1.0 && progress > 0.0) {
      // Calcule une onde sinusoïdale pour un rebond doux et continu
      final rebound = (1 - math.cos(easedProgress * math.pi * 20)) / 2; // 10 rebonds sur la durée
      scale += rebound * reboundAmplitude;
    }

    final currentSize = minDimension * scale;
    return Container(
      width: currentSize,
      height: currentSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.black,
      ),
    );
  }
}
