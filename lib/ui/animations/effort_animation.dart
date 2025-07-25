
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animation d'effort : cercle noir qui diminue progressivement avec le temps
/// Commence à 80% de la plus petite dimension et disparaît à la fin
class EffortAnimation extends StatefulWidget {
  final int durationSeconds; // Durée totale de l'animation

  const EffortAnimation({
    super.key,
    required this.durationSeconds,
  });

  @override
  State<EffortAnimation> createState() => _EffortAnimationState();
}

class _EffortAnimationState extends State<EffortAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.durationSeconds),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    
    // Démarrer l'animation automatiquement
    _controller.forward();
  }

  @override
  void didUpdateWidget(EffortAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.durationSeconds != widget.durationSeconds) {
      _controller.duration = Duration(seconds: widget.durationSeconds);
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final minDimension = math.min(screenSize.width, screenSize.height);
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        final size = minDimension * _scaleAnimation.value;
        return Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black,
          ),
        );
      },
    );
  }
}
