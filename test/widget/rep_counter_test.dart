import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/widgets/rep_counter.dart';
import 'package:sport_app/ui/theme/app_colors.dart';
import 'package:sport_app/ui/theme/app_dimensions.dart';

void main() {
  group('RepCounter Widget Tests', () {
    testWidgets('should display count correctly', (WidgetTester tester) async {
      // Given
      const count = 5;

      // When
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RepCounter(count: count),
          ),
        ),
      );

      // Then
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should display zero correctly', (WidgetTester tester) async {
      // Given
      const count = 0;

      // When
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RepCounter(count: count),
          ),
        ),
      );

      // Then
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('should display large numbers correctly', (WidgetTester tester) async {
      // Given
      const count = 999;

      // When
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RepCounter(count: count),
          ),
        ),
      );

      // Then
      expect(find.text('999'), findsOneWidget);
    });

    testWidgets('should display negative numbers correctly', (WidgetTester tester) async {
      // Given
      const count = -5;

      // When
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RepCounter(count: count),
          ),
        ),
      );

      // Then
      expect(find.text('-5'), findsOneWidget);
    });

    group('Styling', () {
      testWidgets('should have correct container styling', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: 10),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.white);
        expect(decoration.borderRadius, 
               BorderRadius.circular(AppDimensions.buttonRadius * 2));
      });

      testWidgets('should have correct padding', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: 10),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));

        // Then
        expect(container.padding, EdgeInsets.all(AppDimensions.repCounterPadding));
      });

      testWidgets('should use correct text style', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: 42),
            ),
          ),
        );

        // When
        final text = tester.widget<Text>(find.text('42'));

        // Then
        expect(text.style?.color, AppColors.black);
        expect(text.style?.fontFamily, 'Inter');
        expect(text.style?.fontSize, 60.0);
      });
    });

    group('Layout', () {
      testWidgets('should be properly sized', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: RepCounter(count: 15),
              ),
            ),
          ),
        );

        // When
        final size = tester.getSize(find.byType(RepCounter));

        // Then - Should have reasonable dimensions
        expect(size.width, greaterThan(0));
        expect(size.height, greaterThan(0));
      });

      testWidgets('should maintain consistent size with different counts', (WidgetTester tester) async {
        // Given - Test with single digit
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: 5),
            ),
          ),
        );

        final singleDigitSize = tester.getSize(find.byType(RepCounter));

        // When - Test with double digit
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: 25),
            ),
          ),
        );

        final doubleDigitSize = tester.getSize(find.byType(RepCounter));

        // Then - Width should change but height should be similar
        expect(doubleDigitSize.width, greaterThan(singleDigitSize.width));
        expect((doubleDigitSize.height - singleDigitSize.height).abs(), lessThan(5.0));
      });
    });

    group('Accessibility', () {
      testWidgets('should be accessible for screen readers', (WidgetTester tester) async {
        // Given
        const count = 7;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: count),
            ),
          ),
        );

        // When/Then - Should have semantic information
        expect(find.bySemanticsLabel('7'), findsOneWidget);
      });

      testWidgets('should have good contrast', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: 10),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        final text = tester.widget<Text>(find.text('10'));

        // Then - Should have high contrast (black text on white background)
        expect(decoration.color, AppColors.white);
        expect(text.style?.color, AppColors.black);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very large numbers', (WidgetTester tester) async {
        // Given
        const largeCount = 123456;

        // When
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepCounter(count: largeCount),
            ),
          ),
        );

        // Then - Should not throw overflow error
        expect(tester.takeException(), isNull);
        expect(find.text('123456'), findsOneWidget);
      });

      testWidgets('should handle rapid count changes', (WidgetTester tester) async {
        // Given
        int currentCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      RepCounter(count: currentCount),
                      ElevatedButton(
                        onPressed: () => setState(() => currentCount++),
                        child: Text('Increment'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // When - Rapid increments
        for (int i = 0; i < 10; i++) {
          await tester.tap(find.byType(ElevatedButton));
          await tester.pump();
        }

        // Then
        expect(find.text('10'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });
  });
}
