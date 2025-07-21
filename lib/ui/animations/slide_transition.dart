import 'package:flutter/material.dart';
import '../theme/app_animations.dart';

class SlideTransitionY extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const SlideTransitionY({
    super.key,
    required this.child,
    this.duration = AppAnimations.slideMedium,
    this.offset = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: Offset(0, offset / 100), end: Offset.zero),
      duration: duration,
      curve: AppAnimations.ease,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value.dy * 100),
          child: child,
        );
      },
      child: child,
    );
  }
}
