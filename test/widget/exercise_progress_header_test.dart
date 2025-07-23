import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/widgets/exercise_progress_header.dart';
import 'package:sport_app/ui/theme/app_colors.dart';
import 'package:sport_app/ui/theme/app_text_styles.dart';
import 'package:sport_app/ui/theme/app_dimensions.dart';
import 'package:sport_app/ui/theme/app_spacing.dart';

void main() {
  group('ExerciseProgressHeader Widget Tests', () {
    const defaultProps = {
      'currentExerciseIndex': 0,
      'totalExercises': 5,
      'exerciseName': 'Push-ups',
      'currentSet': 1,
      'totalSets': 3,
    };

    testWidgets('should display all required elements', (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExerciseProgressHeader(
              currentExerciseIndex: 0,
              totalExercises: 5,
              exerciseName: 'Push-ups',
              currentSet: 1,
              totalSets: 3,
            ),
          ),
        ),
      );

      // Then
      expect(find.text('1/5'), findsOneWidget); // Exercise fraction
      expect(find.text('Push-ups'), findsOneWidget); // Exercise name
      expect(find.text('1/3'), findsOneWidget); // Set fraction
    });

    group('Exercise Fraction', () {
      testWidgets('should display correct exercise fraction', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 2,
                totalExercises: 8,
                exerciseName: 'Squats',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // Then
        expect(find.text('3/8'), findsOneWidget);
      });

      testWidgets('should have correct styling for exercise fraction', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Push-ups',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // When
        final exerciseFractionContainer = find.ancestor(
          of: find.text('1/5'),
          matching: find.byType(Container),
        ).first;
        
        final container = tester.widget<Container>(exerciseFractionContainer);
        final decoration = container.decoration as BoxDecoration;
        final text = tester.widget<Text>(find.text('1/5'));

        // Then
        expect(decoration.color, AppColors.black);
        expect(decoration.borderRadius, 
               BorderRadius.circular(AppDimensions.buttonRadius));
        expect(container.padding, const EdgeInsets.symmetric(
          horizontal: AppDimensions.progressDotPaddingHorizontal,
          vertical: AppDimensions.progressDotPaddingVertical,
        ));
        expect(text.style, AppTextStyles.exerciseFraction);
      });
    });

    group('Exercise Name', () {
      testWidgets('should display exercise name correctly', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Burpees',
                currentSet: 2,
                totalSets: 4,
              ),
            ),
          ),
        );

        // Then
        expect(find.text('Burpees'), findsOneWidget);
      });

      testWidgets('should have correct styling for exercise name', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Mountain Climbers',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // When
        final text = tester.widget<Text>(find.text('Mountain Climbers'));

        // Then
        expect(text.style, AppTextStyles.exerciseTitle);
        expect(text.textAlign, TextAlign.center);
      });

      testWidgets('should be expandable to fill available space', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Very Long Exercise Name That Should Expand',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // When/Then
        expect(find.byType(Expanded), findsOneWidget);
        expect(find.text('Very Long Exercise Name That Should Expand'), findsOneWidget);
      });
    });

    group('Set Fraction', () {
      testWidgets('should display correct set fraction', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 1,
                totalExercises: 4,
                exerciseName: 'Lunges',
                currentSet: 2,
                totalSets: 5,
              ),
            ),
          ),
        );

        // Then
        expect(find.text('2/5'), findsOneWidget);
      });

      testWidgets('should have correct styling for set fraction', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Push-ups',
                currentSet: 3,
                totalSets: 4,
              ),
            ),
          ),
        );

        // When
        final setFractionContainer = find.ancestor(
          of: find.text('3/4'),
          matching: find.byType(Container),
        ).last;
        
        final container = tester.widget<Container>(setFractionContainer);
        final decoration = container.decoration as BoxDecoration;
        final text = tester.widget<Text>(find.text('3/4'));

        // Then
        expect(decoration.color, AppColors.black);
        expect(decoration.borderRadius, 
               BorderRadius.circular(AppDimensions.buttonRadius));
        expect(container.padding, const EdgeInsets.symmetric(
          horizontal: AppDimensions.progressDotPaddingHorizontal,
          vertical: AppDimensions.progressDotPaddingVertical,
        ));
        expect(text.style, AppTextStyles.exerciseFraction);
      });
    });

    group('Layout', () {
      testWidgets('should have correct horizontal layout', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Push-ups',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // When/Then
        expect(find.byType(Row), findsOneWidget);
        
        final row = tester.widget<Row>(find.byType(Row));
        expect(row.mainAxisAlignment, MainAxisAlignment.center);
      });

      testWidgets('should have correct spacing between elements', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Push-ups',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // When
        final sizedBoxes = find.byType(SizedBox);
        
        // Then - Should have two SizedBox widgets for spacing
        expect(sizedBoxes, findsNWidgets(2));
        
        final sizedBoxWidgets = sizedBoxes.evaluate()
            .map((e) => e.widget as SizedBox)
            .where((w) => w.width == AppSpacing.gapM)
            .toList();
        
        expect(sizedBoxWidgets.length, 2);
      });

      testWidgets('should have correct padding', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Push-ups',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // When
        final paddingWidget = find.descendant(
          of: find.byType(ExerciseProgressHeader),
          matching: find.byType(Padding),
        ).first;
        final padding = tester.widget<Padding>(paddingWidget);

        // Then
        expect(padding.padding, 
               const EdgeInsets.symmetric(horizontal: AppDimensions.mainPadding));
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle single exercise correctly', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 1,
                exerciseName: 'Single Exercise',
                currentSet: 1,
                totalSets: 1,
              ),
            ),
          ),
        );

        // Then
        expect(find.text('1/1'), findsNWidgets(2)); // Both exercise and set fractions
        expect(find.text('Single Exercise'), findsOneWidget);
      });

      testWidgets('should handle large numbers correctly', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 99,
                totalExercises: 100,
                exerciseName: 'Exercise 100',
                currentSet: 50,
                totalSets: 100,
              ),
            ),
          ),
        );

        // Then
        expect(find.text('100/100'), findsOneWidget);
        expect(find.text('Exercise 100'), findsOneWidget);
        expect(find.text('50/100'), findsOneWidget);
      });

      testWidgets('should handle very long exercise names', (WidgetTester tester) async {
        // Given
        const longName = 'This is a very long exercise name that should be handled gracefully without causing layout issues or overflow errors';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: longName,
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // Then - Should not cause overflow
        expect(tester.takeException(), isNull);
        expect(find.text(longName), findsOneWidget);
      });

      testWidgets('should handle empty exercise name', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: '',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // Then
        expect(find.text(''), findsOneWidget);
        expect(find.text('1/5'), findsOneWidget);
        expect(find.text('1/3'), findsOneWidget);
      });

      testWidgets('should handle zero-based indexing correctly', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0, // Zero-based
                totalExercises: 5,
                exerciseName: 'First Exercise',
                currentSet: 1, // One-based
                totalSets: 3,
              ),
            ),
          ),
        );

        // Then - Should display 1-based for user
        expect(find.text('1/5'), findsOneWidget); // 0 + 1 = 1
        expect(find.text('1/3'), findsOneWidget); // Already 1-based
      });
    });

    group('Accessibility', () {
      testWidgets('should be accessible for screen readers', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 2,
                totalExercises: 5,
                exerciseName: 'Accessibility Test',
                currentSet: 2,
                totalSets: 4,
              ),
            ),
          ),
        );

        // When/Then - All text should be readable by screen readers
        expect(find.text('3/5'), findsOneWidget);
        expect(find.text('Accessibility Test'), findsOneWidget);
        expect(find.text('2/4'), findsOneWidget);
      });

      testWidgets('should have good contrast', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ExerciseProgressHeader(
                currentExerciseIndex: 0,
                totalExercises: 5,
                exerciseName: 'Contrast Test',
                currentSet: 1,
                totalSets: 3,
              ),
            ),
          ),
        );

        // When
        final containers = find.byType(Container);
        final fractionContainers = containers.evaluate()
            .map((e) => e.widget as Container)
            .where((c) => c.decoration != null)
            .toList();

        // Then - Fraction containers should have black background
        for (final container in fractionContainers) {
          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, AppColors.black);
        }
      });
    });
  });
}
