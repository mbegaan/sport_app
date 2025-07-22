import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_dimensions.dart';
import 'responsive_builder.dart';

enum AppButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = type == AppButtonType.primary;
    
    return ResponsiveBuilder(
      builder: (context, screenWidth) {
        final buttonHeight = AppDimensions.buttonHeightResponsive(screenWidth);
        
        return SizedBox(
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary ? AppColors.black : AppColors.white,
              foregroundColor: isPrimary ? AppColors.white : AppColors.black,
              textStyle: AppTextStyles.button,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                side: isPrimary
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.black, width: 1),
              ),
              elevation: 0,
            ),
            child: Text(label),
          ),
        );
      },
    );
  }
}
