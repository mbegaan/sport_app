import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const AppScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.mainPadding),
          child: child,
        ),
      ),
    );
  }
}
