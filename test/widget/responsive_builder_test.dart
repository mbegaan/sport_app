import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/widgets/responsive_builder.dart';

void main() {
  group('ResponsiveBuilder Widget Tests', () {
    testWidgets('should call builder with correct screen width', (WidgetTester tester) async {
      // Given
      double capturedWidth = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            builder: (context, screenWidth) {
              capturedWidth = screenWidth;
              return Text('Width: $screenWidth');
            },
          ),
        ),
      );

      // Then
      expect(capturedWidth, greaterThan(0));
      expect(find.textContaining('Width:'), findsOneWidget);
    });

    testWidgets('should rebuild when screen size changes', (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            builder: (context, screenWidth) {
              return Text('Width: ${screenWidth.toInt()}');
            },
          ),
        ),
      );

      // When - change screen size
      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pump();

      // Then
      expect(find.text('Width: 800'), findsOneWidget);
    });

    testWidgets('should handle very small screens', (WidgetTester tester) async {
      // Given
      await tester.binding.setSurfaceSize(const Size(300, 400));
      
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            builder: (context, screenWidth) {
              return Text('Small: ${screenWidth < 400}');
            },
          ),
        ),
      );

      // Then
      expect(find.text('Small: true'), findsOneWidget);
    });

    testWidgets('should handle large screens', (WidgetTester tester) async {
      // Given
      await tester.binding.setSurfaceSize(const Size(1400, 1000));
      
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            builder: (context, screenWidth) {
              return Text('Large: ${screenWidth > 1200}');
            },
          ),
        ),
      );

      // Then
      expect(find.text('Large: true'), findsOneWidget);
    });

    group('Builder Function', () {
      testWidgets('should provide correct context', (WidgetTester tester) async {
        // Given
        BuildContext? capturedContext;
        
        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveBuilder(
              builder: (context, screenWidth) {
                capturedContext = context;
                return const Text('Test');
              },
            ),
          ),
        );

        // Then
        expect(capturedContext, isNotNull);
        expect(capturedContext, isA<BuildContext>());
      });

      testWidgets('should handle builder returning different widgets', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveBuilder(
              builder: (context, screenWidth) {
                if (screenWidth < 600) {
                  return const Icon(Icons.phone);
                } else {
                  return const Icon(Icons.desktop_windows);
                }
              },
            ),
          ),
        );

        // Then (default test size is usually < 600)
        expect(find.byIcon(Icons.phone), findsOneWidget);
        expect(find.byIcon(Icons.desktop_windows), findsNothing);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle zero width gracefully', (WidgetTester tester) async {
        // Given
        await tester.binding.setSurfaceSize(const Size(0, 400));
        
        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveBuilder(
              builder: (context, screenWidth) {
                return Text('Zero: $screenWidth');
              },
            ),
          ),
        );

        // Then
        expect(find.text('Zero: 0.0'), findsOneWidget);
      });
    });
  });
}
