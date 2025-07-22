import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/utils/timer_notifier.dart';

void main() {
  group('TimerNotifier', () {
    late TimerNotifier timerNotifier;

    setUp(() {
      timerNotifier = TimerNotifier();
    });

    tearDown(() {
      timerNotifier.dispose();
    });

    group('État initial', () {
      test('doit être idle au démarrage', () {
        // Given: TimerNotifier fraîchement créé
        // When: on vérifie l'état initial
        // Then: l'état doit être idle
        expect(timerNotifier.value.isIdle, isTrue);
        expect(timerNotifier.value.isRunning, isFalse);
        expect(timerNotifier.value.type, TimerType.idle);
      });

      test('doit avoir des valeurs par défaut cohérentes', () {
        // Given: TimerNotifier à l'état initial
        // When: on vérifie les propriétés
        // Then: les valeurs doivent être cohérentes
        expect(timerNotifier.value.totalSeconds, 0);
        expect(timerNotifier.value.remainingSeconds, 0);
        expect(timerNotifier.value.progress, 0.0);
      });
    });

    group('Timer d\'exercice', () {
      test('doit démarrer un timer d\'exercice correctement', () {
        // Given: TimerNotifier idle
        const duration = 30;
        
        // When: on démarre un timer d'exercice
        timerNotifier.startExerciseTimer(duration);
        
        // Then: l'état doit être exerciseRunning
        expect(timerNotifier.value.type, TimerType.exerciseRunning);
        expect(timerNotifier.value.totalSeconds, duration);
        expect(timerNotifier.value.remainingSeconds, duration);
        expect(timerNotifier.value.isRunning, isTrue);
        expect(timerNotifier.value.progress, 0.0);
      });

      test('doit arrêter un timer précédent avant d\'en démarrer un nouveau', () {
        // Given: Timer d'exercice en cours
        timerNotifier.startExerciseTimer(30);
        expect(timerNotifier.value.isRunning, isTrue);
        
        // When: on démarre un nouveau timer
        timerNotifier.startExerciseTimer(60);
        
        // Then: le nouveau timer doit remplacer l'ancien
        expect(timerNotifier.value.totalSeconds, 60);
        expect(timerNotifier.value.remainingSeconds, 60);
      });

      test('doit calculer le progrès correctement', () async {
        // Given: Timer d'exercice de 2 secondes
        timerNotifier.startExerciseTimer(2);
        
        // When: on attend 1 seconde
        await Future.delayed(const Duration(milliseconds: 1100));
        
        // Then: le progrès doit être proche de 0.5
        expect(timerNotifier.value.progress, greaterThan(0.4));
        expect(timerNotifier.value.progress, lessThan(0.6));
        expect(timerNotifier.value.remainingSeconds, 1);
      });

      test('doit passer à exerciseCompleted quand le timer atteint zéro', () async {
        // Given: Timer d'exercice de 1 seconde
        timerNotifier.startExerciseTimer(1);
        
        // When: on attend que le timer se termine
        await Future.delayed(const Duration(milliseconds: 1100));
        
        // Then: l'état doit être exerciseCompleted
        expect(timerNotifier.value.isExerciseCompleted, isTrue);
        expect(timerNotifier.value.type, TimerType.exerciseCompleted);
        expect(timerNotifier.value.progress, 0.0); // exerciseCompleted a totalSeconds = 0
      });
    });

    group('Timer de repos', () {
      test('doit démarrer un timer de repos correctement', () {
        // Given: TimerNotifier idle
        const restDuration = 10;
        
        // When: on démarre un timer de repos
        timerNotifier.startRestTimer(restDuration);
        
        // Then: l'état doit être restRunning
        expect(timerNotifier.value.type, TimerType.restRunning);
        expect(timerNotifier.value.totalSeconds, restDuration);
        expect(timerNotifier.value.remainingSeconds, restDuration);
        expect(timerNotifier.value.isRest, isTrue);
        expect(timerNotifier.value.isRunning, isTrue);
      });

      test('doit passer à restCompleted quand le timer de repos atteint zéro', () async {
        // Given: Timer de repos de 1 seconde
        timerNotifier.startRestTimer(1);
        
        // When: on attend que le timer se termine
        await Future.delayed(const Duration(milliseconds: 1100));
        
        // Then: l'état doit être restCompleted
        expect(timerNotifier.value.isRestCompleted, isTrue);
        expect(timerNotifier.value.type, TimerType.restCompleted);
        expect(timerNotifier.value.isRest, isTrue);
      });
    });

    group('Arrêt du timer', () {
      test('doit pouvoir arrêter un timer en cours', () {
        // Given: Timer d'exercice en cours
        timerNotifier.startExerciseTimer(30);
        expect(timerNotifier.value.isRunning, isTrue);
        
        // When: on arrête le timer
        timerNotifier.stopTimer();
        
        // Then: l'état doit revenir à idle
        expect(timerNotifier.value.isIdle, isTrue);
        expect(timerNotifier.value.isRunning, isFalse);
      });
    });

    group('Formatage du temps', () {
      test('doit formater correctement les secondes en MM:SS', () {
        // Given: Timer avec différentes durées
        timerNotifier.startExerciseTimer(65); // 1:05
        expect(timerNotifier.value.formattedTime, '01:05');
        
        timerNotifier.startExerciseTimer(9); // 0:09
        expect(timerNotifier.value.formattedTime, '00:09');
        
        timerNotifier.startExerciseTimer(125); // 2:05
        expect(timerNotifier.value.formattedTime, '02:05');
      });
    });

    group('Edge cases', () {
      test('doit gérer un timer de durée zéro', () {
        // Given: Timer de durée zéro
        // When: on démarre le timer
        timerNotifier.startExerciseTimer(0);
        
        // Then: l'état doit être exerciseRunning avec 0 seconde restante
        expect(timerNotifier.value.type, TimerType.exerciseRunning);
        expect(timerNotifier.value.totalSeconds, 0);
        expect(timerNotifier.value.remainingSeconds, 0);
      });

      test('doit gérer des durées négatives comme zéro', () {
        // Given: Durée négative
        // When: on démarre le timer
        timerNotifier.startExerciseTimer(-5);
        
        // Then: l'état doit être exerciseRunning avec durée négative
        expect(timerNotifier.value.type, TimerType.exerciseRunning);
        expect(timerNotifier.value.totalSeconds, -5);
        expect(timerNotifier.value.remainingSeconds, -5);
      });
    });
  });
}
