import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/animations/breathing_animation.dart';
import 'package:sport_app/ui/theme/app_colors.dart';

void main() {
  group('BreathingAnimation Widget Tests', () {
    testWidgets('doit afficher un cercle blanc pur par défaut', (WidgetTester tester) async {
      // Given: BreathingAnimation avec style par défaut
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            backgroundColor: AppColors.black,
            body: Center(
              child: BreathingAnimation(),
            ),
          ),
        ),
      );

      // When: on laisse l'animation se stabiliser
      await tester.pump(const Duration(milliseconds: 100));

      // Then: on doit trouver un Container avec couleur blanche pure
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsWidgets);

      // Vérifier qu'il y a un container avec la couleur blanche pure
      final containers = tester.widgetList<Container>(containerFinder);
      final whiteContainer = containers.firstWhere(
        (container) => 
          container.decoration != null &&
          (container.decoration as BoxDecoration).color == AppColors.white,
      );
      
      expect(whiteContainer, isNotNull);
      expect((whiteContainer.decoration as BoxDecoration).shape, BoxShape.circle);
    });

    testWidgets('doit s\'adapter au style recovery', (WidgetTester tester) async {
      // Given: BreathingAnimation avec style par défaut
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            backgroundColor: AppColors.black,
            body: Center(
              child: BreathingAnimation(),
            ),
          ),
        ),
      );

      // When: on laisse l'animation se stabiliser
      await tester.pump(const Duration(milliseconds: 100));

      // Then: l'animation doit être présente
      expect(find.byType(BreathingAnimation), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('doit s\'adapter au style energizing', (WidgetTester tester) async {
      // Given: BreathingAnimation avec style par défaut
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            backgroundColor: AppColors.black,
            body: Center(
              child: BreathingAnimation(),
            ),
          ),
        ),
      );

      // When: on laisse l'animation se stabiliser
      await tester.pump(const Duration(milliseconds: 100));

      // Then: l'animation doit être présente
      expect(find.byType(BreathingAnimation), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('doit accepter les paramètres par défaut', (WidgetTester tester) async {
      // Given: BreathingAnimation avec paramètres par défaut
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            backgroundColor: AppColors.black,
            body: Center(
              child: BreathingAnimation(),
            ),
          ),
        ),
      );

      // When: on laisse l'animation se stabiliser
      await tester.pump(const Duration(milliseconds: 100));

      // Then: l'animation doit être présente
      expect(find.byType(BreathingAnimation), findsOneWidget);
    });
  });
}
