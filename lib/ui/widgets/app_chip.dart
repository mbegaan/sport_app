import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_spacing.dart';

/// Chip standardisé avec états visuels
class AppChip extends StatelessWidget {
  final String label;
  final AppChipState state;
  final VoidCallback? onTap;

  const AppChip({
    super.key,
    required this.label,
    this.state = AppChipState.normal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.horizontalM(),
        height: 32.0, // Hauteur standardisée pour chips
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          border: _getBorder(),
        ),
        child: Center(
          child: Text(
            label,
            style: _getTextStyle(),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (state) {
      case AppChipState.normal:
        return AppColors.white;
      case AppChipState.selected:
        return AppColors.black;
      case AppChipState.disabled:
        return AppColors.surfacePressed;
      case AppChipState.active:
        return AppColors.success;
      case AppChipState.warning:
        return AppColors.warning;
      case AppChipState.error:
        return AppColors.error;
    }
  }

  Border? _getBorder() {
    switch (state) {
      case AppChipState.normal:
        return Border.all(color: AppColors.grey, width: AppDimensions.borderWidth);
      case AppChipState.selected:
        return null;
      case AppChipState.disabled:
        return Border.all(color: AppColors.primaryDisabled, width: AppDimensions.borderWidth);
      case AppChipState.active:
      case AppChipState.warning:
      case AppChipState.error:
        return null;
    }
  }

  TextStyle _getTextStyle() {
    switch (state) {
      case AppChipState.normal:
        return AppTextStyles.buttonSmall.copyWith(color: AppColors.black);
      case AppChipState.selected:
        return AppTextStyles.buttonSmall;
      case AppChipState.disabled:
        return AppTextStyles.buttonDisabled;
      case AppChipState.active:
      case AppChipState.warning:
      case AppChipState.error:
        return AppTextStyles.buttonSmall;
    }
  }
}

/// États possibles pour les chips
enum AppChipState {
  normal,    // État par défaut
  selected,  // Sélectionné (fond noir)
  disabled,  // Désactivé (gris)
  active,    // Actif (vert)
  warning,   // Attention (orange)
  error,     // Erreur (rouge)
}
