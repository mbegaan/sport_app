import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_button.dart';

/// Widget pour les contrôles de répétitions (+/- et validation)
class RepControls extends StatelessWidget {
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  final VoidCallback? onValidate;
  final bool canValidate;

  const RepControls({
    super.key,
    this.onDecrement,
    this.onIncrement,
    this.onValidate,
    this.canValidate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Bouton -
        Expanded(
          child: GestureDetector(
            onTap: onDecrement,
            child: Container(
              height: AppDimensions.buttonHeight,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
              ),
              child: Icon(
                Icons.remove,
                size: AppDimensions.iconSizeMedium,
                color: AppColors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSpacing.gapM),
        
        // Bouton ✓
        Expanded(
          flex: 2,
          child: SizedBox(
            height: AppDimensions.buttonHeight,
            child: AppButton(
              label: '✓',
              onPressed: canValidate ? onValidate : null,
              type: canValidate ? AppButtonType.primary : AppButtonType.secondary,
            ),
          ),
        ),
        SizedBox(width: AppSpacing.gapM),
        
        // Bouton +
        Expanded(
          child: GestureDetector(
            onTap: onIncrement,
            child: Container(
              height: AppDimensions.buttonHeight,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
              ),
              child: Icon(
                Icons.add,
                size: AppDimensions.iconSizeMedium,
                color: AppColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
