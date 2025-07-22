import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/widgets/app_card.dart';
import 'package:sport_app/ui/theme/app_colors.dart';
import 'package:sport_app/ui/theme/app_spacing.dart';
import 'package:sport_app/ui/theme/app_dimensions.dart';

void main() {
  group('AppCard Widget Tests', () {
    testWidgets('should display child content', (WidgetTester tester) async {
      // Given
      const testText = 'Test Content';
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Text(testText),
            ),
          ),
        ),
      );

      // Then
      expect(find.text(testText), findsOneWidget);
    });

    group('Variants', () {
      testWidgets('compact variant should have small padding', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                variant: AppCardVariant.compact,
                child: Text('Compact'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));

        // Then
        expect(container.padding, AppSpacing.allS());
      });

      testWidgets('standard variant should have medium padding', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                variant: AppCardVariant.standard,
                child: Text('Standard'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));

        // Then
        expect(container.padding, AppSpacing.allM());
      });

      testWidgets('spacious variant should have large padding', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                variant: AppCardVariant.spacious,
                child: Text('Spacious'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));

        // Then
        expect(container.padding, AppSpacing.allL());
      });

      testWidgets('compact variant should have grey border', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                variant: AppCardVariant.compact,
                child: Text('Compact'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;

        // Then
        expect(border.top.color, AppColors.grey);
      });

      testWidgets('standard variant should have black border', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                variant: AppCardVariant.standard,
                child: Text('Standard'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        final border = decoration.border as Border;

        // Then
        expect(border.top.color, AppColors.black);
      });

      testWidgets('spacious variant should have elevated background', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                variant: AppCardVariant.spacious,
                child: Text('Spacious'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.surfaceElevated);
        expect(decoration.border, isNull);
      });
    });

    group('Interaction', () {
      testWidgets('should call onTap when tapped', (WidgetTester tester) async {
        // Given
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                onTap: () => tapped = true,
                child: const Text('Tappable'),
              ),
            ),
          ),
        );

        // When
        await tester.tap(find.byType(AppCard));

        // Then
        expect(tapped, true);
      });
    });

    group('Styling', () {
      testWidgets('should have correct border radius', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Text('Test'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        final borderRadius = decoration.borderRadius as BorderRadius;

        // Then
        expect(borderRadius.topLeft.x, AppDimensions.buttonRadius);
      });

      testWidgets('elevated card should have shadow', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                elevated: true,
                child: Text('Elevated'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.isNotEmpty, true);
      });

      testWidgets('non-elevated card should not have shadow', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                elevated: false,
                child: Text('Flat'),
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.boxShadow, isNull);
      });
    });
  });
}
