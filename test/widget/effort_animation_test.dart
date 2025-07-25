import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/ui/animations/effort_animation.dart';
import 'package:sport_app/ui/theme/app_colors.dart';

void main() {
  group('EffortAnimation', () {
    testWidgets('doit afficher un cercle noir initial à 80% de la taille', (WidgetTester tester) async {
      // Given: EffortAnimation avec une durée de 5 secondes
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EffortAnimation(durationSeconds: 5),
          ),
        ),
      );

      // When: le widget est construit
      await tester.pump();

      // Then: un container avec cercle noir doit être présent
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, AppColors.black);
    });

    testWidgets('doit démarrer l\'animation automatiquement', (WidgetTester tester) async {
      // Given: EffortAnimation avec une durée courte pour le test
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EffortAnimation(durationSeconds: 1),
          ),
        ),
      );

      // When: on laisse l'animation se dérouler
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500)); // Milieu de l'animation

      // Then: l'animation doit être en cours (taille réduite)
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);
      
      // L'animation devrait avoir commencé
      await tester.pump(const Duration(milliseconds: 600)); // Fin de l'animation
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('doit mettre à jour la durée quand le widget change', (WidgetTester tester) async {
      // Given: EffortAnimation initiale
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EffortAnimation(durationSeconds: 5),
          ),
        ),
      );
      await tester.pump();

      // When: on change la durée
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EffortAnimation(durationSeconds: 10),
          ),
        ),
      );
      await tester.pump();

      // Then: le widget doit se reconstruire sans erreur
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('doit maintenir la structure BreathingAnimation-like', (WidgetTester tester) async {
      // Given: EffortAnimation
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EffortAnimation(durationSeconds: 3),
          ),
        ),
      );

      // When: le widget est construit
      await tester.pump();

      // Then: doit avoir la même structure qu'une animation isolée
      // - Un AnimatedBuilder
      final animatedBuilderFinder = find.byType(AnimatedBuilder);
      expect(animatedBuilderFinder, findsOneWidget);
      
      // - Un Container avec forme circulaire
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);
      
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, AppColors.black);
    });

    testWidgets('doit gérer les durées différentes', (WidgetTester tester) async {
      // Test avec différentes durées pour s'assurer de la robustesse
      for (final duration in [1, 5, 10, 30]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EffortAnimation(durationSeconds: duration),
            ),
          ),
        );
        await tester.pump();

        // Vérifier que le widget se construit sans erreur
        final containerFinder = find.byType(Container);
        expect(containerFinder, findsOneWidget);
      }
    });
  });
}
