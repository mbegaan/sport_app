import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/theme/app_dimensions.dart';

void main() {
  group('AppDimensions Responsive Tests', () {
    group('Screen Width Detection', () {
      test('should detect small screen correctly', () {
        expect(AppDimensions.isSmallScreen(400), true);
        expect(AppDimensions.isSmallScreen(599), true);
        expect(AppDimensions.isSmallScreen(600), false);
      });

      test('should detect medium screen correctly', () {
        expect(AppDimensions.isMediumScreen(600), true);
        expect(AppDimensions.isMediumScreen(800), true);
        expect(AppDimensions.isMediumScreen(1199), true);
        expect(AppDimensions.isMediumScreen(1200), false);
        expect(AppDimensions.isMediumScreen(599), false);
      });

      test('should detect large screen correctly', () {
        expect(AppDimensions.isLargeScreen(1200), true);
        expect(AppDimensions.isLargeScreen(1500), true);
        expect(AppDimensions.isLargeScreen(1199), false);
      });
    });

    group('Responsive Padding', () {
      test('should return correct padding for mobile', () {
        expect(AppDimensions.paddingResponsive(400), AppDimensions.mainPadding);
      });

      test('should return correct padding for tablet', () {
        expect(AppDimensions.paddingResponsive(800), 36.0);
      });

      test('should return correct padding for desktop', () {
        expect(AppDimensions.paddingResponsive(1400), 48.0);
      });
    });

    group('Responsive Font Sizes', () {
      test('should return correct exercise title font size for mobile', () {
        expect(
          AppDimensions.exerciseTitleFontSizeResponsive(400),
          AppDimensions.exerciseTitleFontSize,
        );
      });

      test('should return correct exercise title font size for tablet', () {
        expect(
          AppDimensions.exerciseTitleFontSizeResponsive(800),
          14.0,
        );
      });

      test('should return correct exercise title font size for desktop', () {
        expect(
          AppDimensions.exerciseTitleFontSizeResponsive(1400),
          16.0,
        );
      });
    });

    group('Responsive Section Spacing', () {
      test('should return correct section spacing for all screen sizes', () {
        expect(AppDimensions.sectionSpacingResponsive(400), AppDimensions.sectionSpacing);
        expect(AppDimensions.sectionSpacingResponsive(800), AppDimensions.sectionSpacing);
        expect(AppDimensions.sectionSpacingResponsive(1400), AppDimensions.sectionSpacing);
      });
    });
  });
}
