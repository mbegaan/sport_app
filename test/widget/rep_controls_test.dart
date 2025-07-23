import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/widgets/rep_controls.dart';
import 'package:sport_app/ui/widgets/app_button.dart';
import 'package:sport_app/ui/theme/app_colors.dart';
import 'package:sport_app/ui/theme/app_dimensions.dart';
import 'package:sport_app/ui/theme/app_spacing.dart';

void main() {
  group('RepControls Widget Tests', () {
    testWidgets('should display all three controls', (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RepControls(),
          ),
        ),
      );

      // Then
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
      expect(find.text('✓'), findsOneWidget);
    });

    group('Decrement Button', () {
      testWidgets('should call onDecrement when tapped', (WidgetTester tester) async {
        // Given
        bool decrementCalled = false;
        void onDecrement() => decrementCalled = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RepControls(onDecrement: onDecrement),
            ),
          ),
        );

        // When
        await tester.tap(find.byIcon(Icons.remove));
        await tester.pump();

        // Then
        expect(decrementCalled, true);
      });

      testWidgets('should have correct styling', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When
        final gestureDetectors = find.byType(GestureDetector).evaluate().toList();
        final decrementGestureDetector = gestureDetectors[0].widget as GestureDetector;
        final decrementContainer = decrementGestureDetector.child as Container;
        final decoration = decrementContainer.decoration as BoxDecoration;

        // Then
        expect(decoration.color, AppColors.white);
        expect(decoration.borderRadius, 
               BorderRadius.circular(AppDimensions.buttonRadius));
        expect(decrementContainer.constraints?.minHeight, AppDimensions.buttonHeight);
      });

      testWidgets('should have correct icon styling', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When
        final icon = tester.widget<Icon>(find.byIcon(Icons.remove));

        // Then
        expect(icon.size, AppDimensions.iconSizeMedium);
        expect(icon.color, AppColors.black);
      });
    });

    group('Increment Button', () {
      testWidgets('should call onIncrement when tapped', (WidgetTester tester) async {
        // Given
        bool incrementCalled = false;
        void onIncrement() => incrementCalled = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RepControls(onIncrement: onIncrement),
            ),
          ),
        );

        // When
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();

        // Then
        expect(incrementCalled, true);
      });

      testWidgets('should have correct styling', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When - Find the specific containers for +/- buttons
        final containers = find.byType(Container);
        final containerWidgets = containers.evaluate()
            .map((e) => e.widget as Container)
            .where((c) => c.decoration != null && c.child is Icon)
            .toList();

        // Then - Should have at least one container with the expected styling
        expect(containerWidgets.isNotEmpty, true);
        
        final incrementContainer = containerWidgets.last; // Last one should be increment
        final decoration = incrementContainer.decoration as BoxDecoration;
        
        expect(decoration.color, AppColors.white);
        expect(decoration.borderRadius, 
               BorderRadius.circular(AppDimensions.buttonRadius));
      });

      testWidgets('should have correct icon styling', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When
        final icon = tester.widget<Icon>(find.byIcon(Icons.add));

        // Then
        expect(icon.size, AppDimensions.iconSizeMedium);
        expect(icon.color, AppColors.black);
      });
    });

    group('Validate Button', () {
      testWidgets('should call onValidate when enabled and tapped', (WidgetTester tester) async {
        // Given
        bool validateCalled = false;
        void onValidate() => validateCalled = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RepControls(
                onValidate: onValidate,
                canValidate: true,
              ),
            ),
          ),
        );

        // When
        await tester.tap(find.byType(AppButton));
        await tester.pump();

        // Then
        expect(validateCalled, true);
      });

      testWidgets('should not call onValidate when disabled', (WidgetTester tester) async {
        // Given
        bool validateCalled = false;
        void onValidate() => validateCalled = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RepControls(
                onValidate: onValidate,
                canValidate: false,
              ),
            ),
          ),
        );

        // When
        await tester.tap(find.byType(AppButton));
        await tester.pump();

        // Then
        expect(validateCalled, false);
      });

      testWidgets('should use primary type when canValidate is true', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(canValidate: true),
            ),
          ),
        );

        // When
        final appButton = tester.widget<AppButton>(find.byType(AppButton));

        // Then
        expect(appButton.type, AppButtonType.primary);
      });

      testWidgets('should use secondary type when canValidate is false', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(canValidate: false),
            ),
          ),
        );

        // When
        final appButton = tester.widget<AppButton>(find.byType(AppButton));

        // Then
        expect(appButton.type, AppButtonType.secondary);
      });

      testWidgets('should have enabled onPressed when canValidate is true', (WidgetTester tester) async {
        // Given
        void onValidate() {}

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RepControls(
                onValidate: onValidate,
                canValidate: true,
              ),
            ),
          ),
        );

        // When
        final appButton = tester.widget<AppButton>(find.byType(AppButton));

        // Then
        expect(appButton.onPressed, isNotNull);
      });

      testWidgets('should have disabled onPressed when canValidate is false', (WidgetTester tester) async {
        // Given
        void onValidate() {}

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RepControls(
                onValidate: onValidate,
                canValidate: false,
              ),
            ),
          ),
        );

        // When
        final appButton = tester.widget<AppButton>(find.byType(AppButton));

        // Then
        expect(appButton.onPressed, isNull);
      });
    });

    group('Layout', () {
      testWidgets('should have correct spacing between controls', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When
        final row = find.byType(Row);
        final rowWidget = tester.widget<Row>(row);
        final children = rowWidget.children;

        // Then - Should have proper spacing elements in the Row
        expect(children.length, 5); // Expanded, SizedBox, Expanded, SizedBox, Expanded
        
        // Check the SizedBox spacing elements
        final spacingBoxes = children.whereType<SizedBox>().toList();
        expect(spacingBoxes.length, 2);
        expect(spacingBoxes[0].width, AppSpacing.gapM);
        expect(spacingBoxes[1].width, AppSpacing.gapM);
      });

      testWidgets('should have validate button with double width', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When
        final expandedWidgets = find.byType(Expanded).evaluate()
            .map((e) => e.widget as Expanded)
            .toList();

        // Then
        expect(expandedWidgets.length, 3);
        expect(expandedWidgets[0].flex, 1); // Decrement button
        expect(expandedWidgets[1].flex, 2); // Validate button (double width)
        expect(expandedWidgets[2].flex, 1); // Increment button
      });

      testWidgets('should be horizontally laid out', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When/Then
        expect(find.byType(Row), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should be accessible for screen readers', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When/Then - Check that main interactive elements are present
        expect(find.byIcon(Icons.remove), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
        expect(find.text('✓'), findsOneWidget);
      });

      testWidgets('should have semantically meaningful icons', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(),
            ),
          ),
        );

        // When/Then
        expect(find.byIcon(Icons.remove), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.text('✓'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle null callbacks gracefully', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RepControls(
                onDecrement: null,
                onIncrement: null,
                onValidate: null,
              ),
            ),
          ),
        );

        // When - Attempt to tap buttons
        await tester.tap(find.byIcon(Icons.remove));
        await tester.tap(find.byIcon(Icons.add));
        await tester.tap(find.byType(AppButton));
        await tester.pump();

        // Then - Should not throw exceptions
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle rapid successive taps', (WidgetTester tester) async {
        // Given
        int decrementCount = 0;
        int incrementCount = 0;
        int validateCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RepControls(
                onDecrement: () => decrementCount++,
                onIncrement: () => incrementCount++,
                onValidate: () => validateCount++,
                canValidate: true,
              ),
            ),
          ),
        );

        // When - Rapid successive taps
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.byIcon(Icons.remove));
          await tester.tap(find.byIcon(Icons.add));
          await tester.tap(find.byType(AppButton));
          await tester.pump();
        }

        // Then
        expect(decrementCount, 5);
        expect(incrementCount, 5);
        expect(validateCount, 5);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should maintain state when canValidate changes', (WidgetTester tester) async {
        // Given
        bool canValidate = false;

        await tester.pumpWidget(
          MaterialApp(
            home: StatefulBuilder(
              builder: (context, setState) {
                return Scaffold(
                  body: Column(
                    children: [
                      RepControls(
                        canValidate: canValidate,
                        onValidate: () {},
                      ),
                      ElevatedButton(
                        onPressed: () => setState(() => canValidate = !canValidate),
                        child: const Text('Toggle Validate'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );

        // When - Toggle canValidate
        await tester.tap(find.text('Toggle Validate'));
        await tester.pump();

        // Then - Widget should update properly
        final appButton = tester.widget<AppButton>(find.byType(AppButton));
        expect(appButton.type, AppButtonType.primary);
        expect(appButton.onPressed, isNotNull);
      });
    });
  });
}
