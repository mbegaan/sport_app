import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import 'responsive_builder.dart';

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
        child: ResponsiveBuilder(
          builder: (context, screenWidth) {
            final padding = AppDimensions.paddingResponsive(screenWidth);
            
            return Padding(
              padding: EdgeInsets.all(padding),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
