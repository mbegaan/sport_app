/// Tokens d'animation centralisés pour l'app
import 'package:flutter/material.dart';

class AppAnimations {
  static const Duration fadeShort = Duration(milliseconds: 200);
  static const Duration fadeMedium = Duration(milliseconds: 400);
  static const Duration slideShort = Duration(milliseconds: 250);
  static const Duration slideMedium = Duration(milliseconds: 500);

  static const Curve ease = Curves.easeInOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
}
