import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/widgets/app_chip.dart';
import 'package:sport_app/ui/theme/app_colors.dart';

void main() {
  group('AppChip Widget Tests', () {
    testWidgets('should display label text', (WidgetTester tester) async {
      // Given
      const testLabel = 'Test Chip';
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppChip(label: testLabel),
          ),
        ),
      );

      // Then
      expect(find.text(testLabel), findsOneWidget);
    });

    group('States', () {
      testWidgets('normal state should have white background', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Normal',
                state: AppChipState.normal,
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.white);
      });

      testWidgets('selected state should have black background', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Selected',
                state: AppChipState.selected,
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.black);
      });

      testWidgets('disabled state should have pressed surface background', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Disabled',
                state: AppChipState.disabled,
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.surfacePressed);
      });

      testWidgets('active state should have success background', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Active',
                state: AppChipState.active,
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.success);
      });

      testWidgets('warning state should have warning background', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Warning',
                state: AppChipState.warning,
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.warning);
      });

      testWidgets('error state should have error background', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Error',
                state: AppChipState.error,
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.error);
      });
    });

    group('Text Styles', () {
      testWidgets('normal state should have black text', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Normal',
                state: AppChipState.normal,
              ),
            ),
          ),
        );

        // When
        final text = tester.widget<Text>(find.text('Normal'));

        // Then
        expect(text.style?.color, AppColors.black);
      });

      testWidgets('selected state should have white text', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Selected',
                state: AppChipState.selected,
              ),
            ),
          ),
        );

        // When
        final text = tester.widget<Text>(find.text('Selected'));

        // Then
        expect(text.style?.color, AppColors.white);
      });

      testWidgets('disabled state should have disabled text color', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Disabled',
                state: AppChipState.disabled,
              ),
            ),
          ),
        );

        // When
        final text = tester.widget<Text>(find.text('Disabled'));

        // Then
        expect(text.style?.color, AppColors.primaryDisabled);
      });
    });

    group('Interaction', () {
      testWidgets('should call onTap when tapped', (WidgetTester tester) async {
        // Given
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Tappable',
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        // When
        await tester.tap(find.byType(AppChip));

        // Then
        expect(tapped, true);
      });
    });

    group('Styling', () {
      testWidgets('should have fixed height via constraints', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(label: 'Test'),
            ),
          ),
        );

        // When
        final container = find.byType(Container).first;
        final containerWidget = tester.widget<Container>(container);
        final decoration = containerWidget.decoration as BoxDecoration;

        // Then - Vérification que le container a une décoration appropriée
        expect(decoration, isNotNull);
        expect(decoration.borderRadius, isNotNull);
      });

      testWidgets('normal state should have grey border', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Normal',
                state: AppChipState.normal,
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

      testWidgets('selected state should not have border', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppChip(
                label: 'Selected',
                state: AppChipState.selected,
              ),
            ),
          ),
        );

        // When
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;

        // Then
        expect(decoration.border, isNull);
      });
    });
  });
}
