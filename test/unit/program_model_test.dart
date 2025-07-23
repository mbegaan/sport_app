import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/data/program_model.dart';

void main() {
  group('Program Model', () {
    group('Program fromJson', () {
      test('doit parser un JSON complet correctement', () {
        // Given: Un JSON complet avec la structure attendue
        final json = {
          'program': {
            'name': 'Programme Test',
            'objective': 'Objectif test',
            'muscles': ['biceps', 'triceps'],
            'goals': ['force', 'endurance'],
            'sessions_per_week': [2, 3],
            'sessions': [
              {
                'id': 1,
                'name': 'Session 1',
                'focus': 'Focus test',
                'exercises': []
              }
            ],
            'general_tips': {
              'tempo': {'eccentric': 2, 'pause': 1, 'concentric': 2},
              'rest_between_sets_sec': {'min': 60, 'max': 90},
              'breathing': 'Respiration test',
              'journaling': 'Journal test'
            }
          }
        };

        // When: on parse le JSON
        final program = Program.fromJson(json);

        // Then: toutes les propriétés doivent être correctes
        expect(program.name, 'Programme Test');
        expect(program.objective, 'Objectif test');
        expect(program.muscles, ['biceps', 'triceps']);
        expect(program.goals, ['force', 'endurance']);
        expect(program.sessionsPerWeek, [2, 3]);
        expect(program.sessions, hasLength(1));
        expect(program.generalTips.breathing, 'Respiration test');
      });

      test('doit gérer les listes vides', () {
        // Given: Un JSON avec des listes vides
        final json = {
          'program': {
            'name': 'Programme Vide',
            'objective': 'Test',
            'muscles': <String>[],
            'goals': <String>[],
            'sessions_per_week': <int>[],
            'sessions': <Map<String, dynamic>>[],
            'general_tips': {
              'tempo': {'eccentric': 2, 'pause': 1, 'concentric': 2},
              'rest_between_sets_sec': {'min': 60, 'max': 90},
              'breathing': 'Test',
              'journaling': 'Test'
            }
          }
        };

        // When: on parse le JSON
        final program = Program.fromJson(json);

        // Then: les listes doivent être vides mais non null
        expect(program.muscles, isEmpty);
        expect(program.goals, isEmpty);
        expect(program.sessionsPerWeek, isEmpty);
        expect(program.sessions, isEmpty);
      });

      test('doit lever une exception pour les champs obligatoires manquants', () {
        // Given: Un JSON sans champs obligatoires
        final incompleteJson = <String, dynamic>{
          'program': {
            'name': 'Programme Incomplet',
            // 'objective' manquant
            'muscles': <String>[],
            'goals': <String>[],
            'sessions_per_week': <int>[],
            'sessions': <Map<String, dynamic>>[],
          }
        };

        // When/Then: le parsing doit lever une exception
        expect(
          () => Program.fromJson(incompleteJson),
          throwsA(isA<TypeError>()),
        );
      });
    });
  });

  group('Session Model', () {
    group('Session fromJson', () {
      test('doit parser un JSON de session correctement', () {
        // Given: Un JSON de session complet
        final json = {
          'id': 42,
          'name': 'Session Test',
          'focus': 'Focus test',
          'exercises': [
            {
              'name': 'Exercise Test',
              'sets': 3,
              'reps': {'min': 8, 'max': 12},
              'notes': 'Notes test'
            }
          ]
        };

        // When: on parse le JSON
        final session = Session.fromJson(json);

        // Then: toutes les propriétés doivent être correctes
        expect(session.id, 42);
        expect(session.name, 'Session Test');
        expect(session.focus, 'Focus test');
        expect(session.exercises, hasLength(1));
        expect(session.exercises.first.name, 'Exercise Test');
      });

      test('doit gérer une session sans exercices', () {
        // Given: Un JSON de session sans exercices
        final json = {
          'id': 1,
          'name': 'Session Vide',
          'focus': 'Test',
          'exercises': <Map<String, dynamic>>[]
        };

        // When: on parse le JSON
        final session = Session.fromJson(json);

        // Then: la liste d'exercices doit être vide
        expect(session.exercises, isEmpty);
      });
    });
  });

  group('Exercise Model', () {
    group('Exercise fromJson', () {
      test('doit parser un exercice avec reps Map (min/max)', () {
        // Given: Un JSON avec reps comme Map
        final json = {
          'name': 'Push-ups',
          'sets': 3,
          'reps': {'min': 8, 'max': 12},
          'notes': 'Forme parfaite'
        };

        // When: on parse le JSON
        final exercise = Exercise.fromJson(json);

        // Then: l'exercice doit être correctement parsé
        expect(exercise.name, 'Push-ups');
        expect(exercise.sets, 3);
        expect(exercise.reps, isNotNull);
        expect(exercise.reps, [8, 12]);
        expect(exercise.notes, 'Forme parfaite');
        expect(exercise.numberOfReps, 8); // min
      });

      test('doit parser un exercice avec duration_sec', () {
        // Given: Un JSON avec duration_sec
        final json = {
          'name': 'Planche',
          'sets': 3,
          'duration_sec': 30,
          'notes': 'Tenir la position'
        };

        // When: on parse le JSON
        final exercise = Exercise.fromJson(json);

        // Then: l'exercice doit avoir une durée
        expect(exercise.name, 'Planche');
        expect(exercise.durationSec, 30);
        expect(exercise.isDurationBased, true);
        expect(exercise.exerciseDuration, 30);
      });

      test('doit parser un exercice avec duration_sec Map (min/max)', () {
        // Given: Un JSON avec duration_sec comme Map
        final json = {
          'name': 'Planche Variable',
          'sets': 3,
          'duration_sec': {'min': 20, 'max': 40},
          'notes': 'Durée variable'
        };

        // When: on parse le JSON
        final exercise = Exercise.fromJson(json);

        // Then: l'exercice doit prendre la durée min
        expect(exercise.name, 'Planche Variable');
        expect(exercise.durationSec, 20); // min value
        expect(exercise.isDurationBased, true);
      });

      test('doit gérer les champs optionnels manquants', () {
        // Given: Un JSON minimal
        final json = {
          'name': 'Exercise Minimal',
          'sets': 1,
          // 'reps', 'notes', 'duration_sec' manquants
        };

        // When: on parse le JSON
        final exercise = Exercise.fromJson(json);

        // Then: les champs optionnels doivent avoir des valeurs par défaut
        expect(exercise.name, 'Exercise Minimal');
        expect(exercise.notes, null);
        expect(exercise.durationSec, null);
        expect(exercise.isDurationBased, false);
        expect(exercise.restSec, 60); // valeur par défaut
      });

      test('doit parser reps_per_leg', () {
        // Given: Un JSON avec reps_per_leg
        final json = {
          'name': 'Squats Bulgares',
          'sets': 3,
          'reps_per_leg': 12,
          'notes': 'Chaque jambe'
        };

        // When: on parse le JSON
        final exercise = Exercise.fromJson(json);

        // Then: repsPerLeg doit être défini
        expect(exercise.name, 'Squats Bulgares');
        expect(exercise.repsPerLeg, 12);
        expect(exercise.numberOfReps, 12);
        expect(exercise.isDurationBased, false);
      });
    });

    group('Exercise properties', () {
      test('isDurationBased doit retourner true si durationSec > 0', () {
        // Given: Un exercice avec durationSec
        const exercise = Exercise(
          name: 'Planche',
          sets: 3,
          durationSec: 45,
          notes: '',
        );

        // When/Then: isDurationBased doit être true
        expect(exercise.isDurationBased, true);
        expect(exercise.exerciseDuration, 45);
      });

      test('isDurationBased doit retourner false si pas de durée', () {
        // Given: Un exercice sans durée
        const exercise = Exercise(
          name: 'Push-ups',
          sets: 3,
          reps: [10, 15],
          notes: '',
        );

        // When/Then: isDurationBased doit être false
        expect(exercise.isDurationBased, false);
        expect(exercise.exerciseDuration, null);
      });

      test('numberOfSets doit gérer les sets int et Map', () {
        // Given: Des exercices avec différents types de sets
        const exerciseWithIntSets = Exercise(
          name: 'Exercise 1',
          sets: 4,
        );

        const exerciseWithMapSets = Exercise(
          name: 'Exercise 2',
          sets: {'min': 2, 'max': 4},
        );

        // When/Then: numberOfSets doit retourner la bonne valeur
        expect(exerciseWithIntSets.numberOfSets, 4);
        expect(exerciseWithMapSets.numberOfSets, 2); // min value
      });

      test('numberOfReps doit gérer différents types de reps', () {
        // Given: Des exercices avec différents types de reps
        const exerciseWithReps = Exercise(
          name: 'Exercise 1',
          sets: 3,
          reps: [8, 12],
        );

        const exerciseWithRepsPerLeg = Exercise(
          name: 'Exercise 2',
          sets: 3,
          repsPerLeg: 10,
        );

        const exerciseWithRepsPerArm = Exercise(
          name: 'Exercise 3',
          sets: 3,
          repsPerArm: 15,
        );

        const exerciseWithoutReps = Exercise(
          name: 'Exercise 4',
          sets: 3,
        );

        // When/Then: numberOfReps doit retourner la bonne valeur
        expect(exerciseWithReps.numberOfReps, 8); // min
        expect(exerciseWithRepsPerLeg.numberOfReps, 10);
        expect(exerciseWithRepsPerArm.numberOfReps, 15);
        expect(exerciseWithoutReps.numberOfReps, null);
      });
    });
  });

  group('GeneralTips Model', () {
    test('doit parser correctement avec rest_between_sets_sec Map', () {
      // Given: Un JSON de conseils généraux avec Map pour rest
      final json = {
        'tempo': {'eccentric': 3, 'pause': 2, 'concentric': 1},
        'rest_between_sets_sec': {'min': 60, 'max': 120},
        'breathing': 'Respiration profonde',
        'journaling': 'Noter les progrès'
      };

      // When: on parse le JSON
      final tips = GeneralTips.fromJson(json);

      // Then: les données doivent être correctement parsées
      expect(tips.tempo['eccentric'], 3);
      expect(tips.tempo['pause'], 2);
      expect(tips.tempo['concentric'], 1);
      expect(tips.restBetweenSets, [60, 120]);
      expect(tips.breathing, 'Respiration profonde');
      expect(tips.journaling, 'Noter les progrès');
    });

    test('doit gérer rest_on_tractions_max_sec optionnel', () {
      // Given: Un JSON avec rest_on_tractions
      final json = {
        'tempo': {'eccentric': 2, 'pause': 1, 'concentric': 2},
        'rest_between_sets_sec': {'min': 60, 'max': 90},
        'rest_on_tractions_max_sec': 180,
        'breathing': 'Test',
        'journaling': 'Test'
      };

      // When: on parse le JSON
      final tips = GeneralTips.fromJson(json);

      // Then: restOnTractions doit être défini
      expect(tips.restOnTractions, 180);
    });
  });
}
