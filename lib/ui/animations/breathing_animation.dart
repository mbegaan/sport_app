import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BreathingAnimation extends StatefulWidget {
  const BreathingAnimation({super.key});

  @override
  State<BreathingAnimation> createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<BreathingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.2,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const _BreathingCurve(),
    ));
    _controller.repeat();
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
            color: AppColors.white,
          ),
        );
      },
    );
  }
}

class _BreathingCurve extends Curve {
  const _BreathingCurve();
  @override
  double transformInternal(double t) {
    if (t <= 0.5) {
      return Curves.easeInOut.transform(t * 2);
    } else {
      return Curves.easeInOut.transform((1 - t) * 2);
    }
  }
}
