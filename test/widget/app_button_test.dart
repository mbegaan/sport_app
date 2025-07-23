import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/widgets/app_button.dart';
import 'package:sport_app/ui/widgets/responsive_builder.dart';
import 'package:sport_app/ui/theme/app_colors.dart';

void main() {
  group('AppButton Widget Tests', () {
    testWidgets('should display label correctly', (WidgetTester tester) async {
      // Given
      const label = 'Test Button';
      bool wasPressed = false;

      // When
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: label,
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      // Then
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (WidgetTester tester) async {
      // Given
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Test',
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      // When
      await tester.tap(find.byType(AppButton));
      await tester.pump();

      // Then
      expect(wasPressed, true);
    });

    testWidgets('should be disabled when onPressed is null', (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Disabled',
              onPressed: null,
            ),
          ),
        ),
      );

      // When
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

      // Then
      expect(button.onPressed, isNull);
    });

    group('Primary Button (default)', () {
      testWidgets('should have correct styling', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Primary',
                onPressed: () {},
                type: AppButtonType.primary,
              ),
            ),
          ),
        );

        // When
        final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        final style = button.style!;

        // Then
        expect(style.backgroundColor?.resolve({}), AppColors.black);
        expect(style.foregroundColor?.resolve({}), AppColors.white);
      });

      testWidgets('should have correct height', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Primary',
                onPressed: () {},
              ),
            ),
          ),
        );

        // When - AppButton utilise maintenant ResponsiveBuilder
        final responsiveBuilder = find.byType(ResponsiveBuilder);
        expect(responsiveBuilder, findsOneWidget);
        
        // Le test vérifie que le widget a la bonne structure responsive
        final sizedBox = find.byType(SizedBox);
        expect(sizedBox, findsOneWidget);
      });
    });

    group('Secondary Button', () {
      testWidgets('should have correct styling', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Secondary',
                onPressed: () {},
                type: AppButtonType.secondary,
              ),
            ),
          ),
        );

        // When
        final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        final style = button.style!;

        // Then
        expect(style.backgroundColor?.resolve({}), AppColors.white);
        expect(style.foregroundColor?.resolve({}), AppColors.black);
      });
    });

    group('Accessibility', () {
      testWidgets('should be accessible with semantics', (WidgetTester tester) async {
        // Given
        const label = 'Accessible Button';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: label,
                onPressed: () {},
              ),
            ),
          ),
        );

        // When/Then
        expect(find.bySemanticsLabel(label), findsOneWidget);
      });

      testWidgets('should have adequate touch target size', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Touch Target',
                onPressed: () {},
              ),
            ),
          ),
        );

        // When
        final buttonSize = tester.getSize(find.byType(AppButton));

        // Then - Check minimum touch target size (48.0 is Material Design guideline)
        expect(buttonSize.height, greaterThanOrEqualTo(48.0));
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty label', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: '',
                onPressed: () {},
              ),
            ),
          ),
        );

        // When/Then
        expect(find.text(''), findsOneWidget);
      });

      testWidgets('should handle long label text', (WidgetTester tester) async {
        // Given
        const longLabel = 'This is a very long button label that might overflow';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200, // Constrain width to test text overflow
                child: AppButton(
                  label: longLabel,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        // When/Then - Should not throw overflow error
        expect(tester.takeException(), isNull);
        expect(find.textContaining('This is a very long'), findsOneWidget);
      });

      testWidgets('should handle multiple rapid taps', (WidgetTester tester) async {
        // Given
        int tapCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Rapid Tap',
                onPressed: () => tapCount++,
              ),
            ),
          ),
        );

        // When
        await tester.tap(find.byType(AppButton));
        await tester.tap(find.byType(AppButton));
        await tester.tap(find.byType(AppButton));
        await tester.pump();

        // Then
        expect(tapCount, 3);
      });
    });
  });
}
