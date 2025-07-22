import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_spacing.dart';
import '../theme/app_shadows.dart';

/// Carte standardisée utilisant le design system étendu
class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final AppCardVariant variant;
  final bool elevated;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.variant = AppCardVariant.standard,
    this.elevated = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: _getPadding(),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          border: _getBorder(),
          boxShadow: elevated ? AppShadows.cardShadow : null,
        ),
        child: child,
      ),
    );
  }

  EdgeInsets _getPadding() {
    switch (variant) {
      case AppCardVariant.compact:
        return AppSpacing.allS();
      case AppCardVariant.standard:
        return AppSpacing.allM();
      case AppCardVariant.spacious:
        return AppSpacing.allL();
    }
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case AppCardVariant.compact:
        return AppColors.white;
      case AppCardVariant.standard:
        return AppColors.white;
      case AppCardVariant.spacious:
        return AppColors.surfaceElevated;
    }
  }

  Border? _getBorder() {
    switch (variant) {
      case AppCardVariant.compact:
        return Border.all(color: AppColors.grey, width: AppDimensions.borderWidth);
      case AppCardVariant.standard:
        return Border.all(color: AppColors.black, width: AppDimensions.borderWidth);
      case AppCardVariant.spacious:
        return null; // Pas de bordure pour le variant spacieux
    }
  }
}

/// Variantes de carte disponibles
enum AppCardVariant {
  compact,   // Petit padding, bordure grise
  standard,  // Padding standard, bordure noire
  spacious,  // Grand padding, fond élevé, pas de bordure
}
