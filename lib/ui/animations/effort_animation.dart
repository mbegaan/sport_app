import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animation d'effort - Disque noir qui se réduit progressivement
/// Commence à 80% de la plus petite dimension et se réduit jusqu'à 0%
class EffortAnimation extends StatelessWidget {
  final double progress; // 0.0 = début (80%), 1.0 = fin (0%)

  const EffortAnimation({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final minDimension = math.min(screenSize.width, screenSize.height);
    final currentSize = minDimension * 0.8 * (1.0 - progress);
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
