import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/theme/app_colors.dart';
import 'package:sport_app/ui/theme/app_spacing.dart';
import 'package:sport_app/ui/theme/app_dimensions.dart';
import 'package:sport_app/ui/theme/app_text_styles.dart';
import 'package:sport_app/ui/theme/app_animations.dart';
import 'package:sport_app/ui/theme/app_shadows.dart';
import 'package:sport_app/ui/theme/design_system_validator.dart';

void main() {
  group('Design System Extended Tests', () {
    group('AppColors Extended', () {
      test('should have semantic colors defined', () {
        expect(AppColors.success, isA<Color>());
        expect(AppColors.warning, isA<Color>());
        expect(AppColors.error, isA<Color>());
        expect(AppColors.info, isA<Color>());
      });

      test('should have surface variants defined', () {
        expect(AppColors.greyLight, isA<Color>());
        expect(AppColors.greyDark, isA<Color>());
      });

      test('should maintain design consistency with aliases', () {
        expect(AppColors.accentPrimary, AppColors.black);
        expect(AppColors.accentSecondary, AppColors.grey);
      });
    });

    group('AppSpacing Extended', () {
      test('should have extended spacing tokens', () {
        expect(AppSpacing.gapXXL, 64.0);
        expect(AppSpacing.gapXXXL, 96.0);
      });

      test('should have semantic spacing aliases', () {
        expect(AppSpacing.sectionGap, AppSpacing.gapXL);
        expect(AppSpacing.itemGap, AppSpacing.gapM);
        expect(AppSpacing.inlineGap, AppSpacing.gapS);
        expect(AppSpacing.marginGap, AppSpacing.gapL);
      });

      test('should have specialized spacing tokens', () {
        expect(AppSpacing.buttonSpacing, AppSpacing.gapM);
        expect(AppSpacing.textSpacing, AppSpacing.gapS);
        expect(AppSpacing.cardSpacing, AppSpacing.gapL);
        expect(AppSpacing.formSpacing, AppSpacing.gapM);
      });
    });

    group('AppTextStyles Extended', () {
      test('should have navigation and header styles', () {
        expect(AppTextStyles.navigationItem.fontSize, 14.0);
        expect(AppTextStyles.pageTitle.fontSize, 28.0);
        expect(AppTextStyles.sectionHeader.fontSize, 16.0);
      });

      test('should have semantic message styles', () {
        expect(AppTextStyles.successMessage.color, AppColors.success);
        expect(AppTextStyles.warningMessage.color, AppColors.warning);
        expect(AppTextStyles.infoMessage.color, AppColors.info);
      });

      test('should have form input styles', () {
        expect(AppTextStyles.inputLabel.fontSize, 14.0);
        expect(AppTextStyles.inputText.fontSize, 16.0);
        expect(AppTextStyles.inputPlaceholder.color, AppColors.grey);
      });

      test('should have content hierarchy styles', () {
        expect(AppTextStyles.caption.fontSize, 12.0);
        expect(AppTextStyles.metadata.fontSize, 11.0);
        expect(AppTextStyles.caption.color, AppColors.grey);
      });
    });

    group('AppDimensions Extended', () {
      test('should have avatar sizes defined', () {
        expect(AppDimensions.avatarSizeSmall, 32.0);
        expect(AppDimensions.avatarSizeMedium, 64.0);
        expect(AppDimensions.avatarSizeLarge, 96.0);
      });

      test('should have card dimensions defined', () {
        expect(AppDimensions.cardMinHeight, 120.0);
        expect(AppDimensions.cardMaxWidth, 400.0);
      });

      test('should have interface element dimensions', () {
        expect(AppDimensions.floatingActionButtonSize, 56.0);
        expect(AppDimensions.bottomNavHeight, 60.0);
        expect(AppDimensions.appBarHeight, 56.0);
      });

      test('should have responsive methods for extended dimensions', () {
        // Mobile screen
        expect(AppDimensions.cardPaddingResponsive(400), AppSpacing.gapM);
        expect(AppDimensions.avatarSizeResponsive(400), AppDimensions.avatarSizeMedium);
        
        // Desktop screen
        expect(AppDimensions.cardPaddingResponsive(1400), AppSpacing.gapL);
        expect(AppDimensions.avatarSizeResponsive(1400), AppDimensions.avatarSizeLarge);
      });
    });

    group('AppAnimations Extended', () {
      test('should have extended duration tokens', () {
        expect(AppAnimations.fadeLong, const Duration(milliseconds: 600));
        expect(AppAnimations.slideLong, const Duration(milliseconds: 750));
        expect(AppAnimations.scaleDuration, const Duration(milliseconds: 300));
        expect(AppAnimations.rotateDuration, const Duration(milliseconds: 500));
      });

      test('should have specialized durations', () {
        expect(AppAnimations.timerTick, const Duration(milliseconds: 100));
        expect(AppAnimations.breathingCycle, const Duration(seconds: 4));
        expect(AppAnimations.effortAnimation, const Duration(milliseconds: 800));
        expect(AppAnimations.pageTransition, const Duration(milliseconds: 300));
        expect(AppAnimations.snackBarDuration, const Duration(seconds: 3));
      });

      test('should have extended curves', () {
        expect(AppAnimations.bounceIn, Curves.elasticOut);
        expect(AppAnimations.smooth, Curves.easeInOutCubic);
        expect(AppAnimations.sharp, Curves.easeInOutQuart);
        expect(AppAnimations.gentle, Curves.easeInOutSine);
      });

      test('should have fitness-specific curves', () {
        expect(AppAnimations.breathingCurve, Curves.easeInOutSine);
        expect(AppAnimations.effortCurve, Curves.easeInQuart);
        expect(AppAnimations.recoveryCurve, Curves.easeOutCubic);
      });
    });

    group('AppShadows', () {
      test('should have base shadow definitions', () {
        expect(AppShadows.none.color, Colors.transparent);
        expect(AppShadows.subtle.blurRadius, 4.0);
        expect(AppShadows.soft.blurRadius, 8.0);
        expect(AppShadows.medium.blurRadius, 16.0);
      });

      test('should have specialized shadows', () {
        expect(AppShadows.floating.blurRadius, 24.0);
        expect(AppShadows.modal.blurRadius, 32.0);
      });

      test('should have colored shadows for special effects', () {
        expect(AppShadows.successGlow.color.value, const Color(0x20059669).value);
        expect(AppShadows.errorGlow.color.value, const Color(0x20DC2626).value);
      });

      test('should have shadow lists for common use cases', () {
        expect(AppShadows.cardShadow.length, 1);
        expect(AppShadows.buttonShadow.first, AppShadows.none);
        expect(AppShadows.floatingButtonShadow.first, AppShadows.floating);
        expect(AppShadows.modalShadow.first, AppShadows.modal);
      });

      test('should provide elevation-based shadows', () {
        expect(AppShadows.forElevation(0), [AppShadows.none]);
        expect(AppShadows.forElevation(2), [AppShadows.subtle]);
        expect(AppShadows.forElevation(4), [AppShadows.soft]);
        expect(AppShadows.forElevation(8), [AppShadows.medium]);
        expect(AppShadows.forElevation(16), [AppShadows.floating]);
        expect(AppShadows.forElevation(24), [AppShadows.modal]);
      });

      test('should provide responsive shadows', () {
        expect(AppShadows.responsiveShadow(400), [AppShadows.subtle]); // Mobile
        expect(AppShadows.responsiveShadow(1200), [AppShadows.soft]); // Desktop
      });
    });

    group('DesignSystemValidator', () {
      test('should validate colors correctly', () {
        expect(DesignSystemValidator.isValidColor(AppColors.black), true);
        expect(DesignSystemValidator.isValidColor(AppColors.success), true);
        expect(DesignSystemValidator.isValidColor(const Color(0xFF123456)), false);
      });

      test('should validate spacing correctly', () {
        expect(DesignSystemValidator.isValidSpacing(AppSpacing.gapM), true);
        expect(DesignSystemValidator.isValidSpacing(AppDimensions.mainPadding), true);
        expect(DesignSystemValidator.isValidSpacing(13.0), false);
      });

      test('should validate durations correctly', () {
        expect(DesignSystemValidator.isValidDuration(AppAnimations.fadeShort), true);
        expect(DesignSystemValidator.isValidDuration(AppAnimations.breathingCycle), true);
        expect(DesignSystemValidator.isValidDuration(const Duration(milliseconds: 123)), false);
      });

      test('should provide color recommendations', () {
        final recommendation = DesignSystemValidator.getColorRecommendation(Colors.black);
        expect(recommendation, contains('AppColors.black'));
      });

      test('should find nearest valid spacing', () {
        expect(DesignSystemValidator.getNearestValidSpacing(10), AppSpacing.gapS); // 8
        expect(DesignSystemValidator.getNearestValidSpacing(20), AppSpacing.gapM); // 16
        expect(DesignSystemValidator.getNearestValidSpacing(30), AppSpacing.gapL); // 24
      });

      test('should validate typography hierarchy', () {
        expect(DesignSystemValidator.isValidTypographyHierarchy(16, 16), true); // Equal
        expect(DesignSystemValidator.isValidTypographyHierarchy(24, 16), true); // 1.5 ratio
        expect(DesignSystemValidator.isValidTypographyHierarchy(20, 16), true); // 1.25 ratio
        expect(DesignSystemValidator.isValidTypographyHierarchy(26, 16), true); // 1.625 ratio ~ 1.618 Golden ratio
      });

      test('should validate color contrast', () {
        expect(DesignSystemValidator.hasGoodContrast(AppColors.black, AppColors.white), true);
        expect(DesignSystemValidator.hasGoodContrast(AppColors.white, AppColors.black), true);
        expect(DesignSystemValidator.hasGoodContrast(AppColors.grey, AppColors.white), true);
        expect(DesignSystemValidator.hasGoodContrast(AppColors.greyLight, AppColors.white), false);
      });
    });

    group('Design System Integration', () {
      test('should maintain consistency across color systems', () {
        // Vérifie que les couleurs d'accent pointent bien vers les couleurs principales
        expect(AppColors.accentPrimary, AppColors.black);
        expect(AppColors.accentSecondary, AppColors.grey);
      });

      test('should maintain spacing progression', () {
        // Vérifie la progression géométrique des espacements
        expect(AppSpacing.gapS, AppSpacing.gapXS * 2);
        expect(AppSpacing.gapM, AppSpacing.gapS * 2);
        expect(AppSpacing.gapL, AppSpacing.gapM * 1.5);
        expect(AppSpacing.gapXL, closeTo(AppSpacing.gapL * 1.667, 0.1));
      });

      test('should maintain animation duration progression', () {
        // Vérifie que les durées suivent une progression logique
        expect(AppAnimations.fadeShort.inMilliseconds, lessThan(AppAnimations.fadeMedium.inMilliseconds));
        expect(AppAnimations.fadeMedium.inMilliseconds, lessThan(AppAnimations.fadeLong.inMilliseconds));
        expect(AppAnimations.slideShort.inMilliseconds, lessThan(AppAnimations.slideMedium.inMilliseconds));
      });
    });
  });
}
