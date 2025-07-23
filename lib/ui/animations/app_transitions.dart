import 'package:flutter/material.dart';
import 'fade_in.dart';
import 'slide_transition.dart';

class AppTransitions {
  static Widget fadeIn(Widget child, {Duration? duration}) =>
      FadeIn(duration: duration ?? const Duration(milliseconds: 400), child: child);

  static Widget slideY(Widget child, {Duration? duration, double offset = 40.0}) =>
      SlideTransitionY(duration: duration ?? const Duration(milliseconds: 500), offset: offset, child: child);
}
