import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/muscle.dart';
import '../models/exercise.dart';
import '../models/program.dart';
import '../services/isar_service.dart';

/// Service de migration des données JSON vers Isar
class MigrationService {
  
  /// Effectue la migration complète des données depuis les fichiers JSON
  static Future<void> migrateFromJson() async {
    print('🚀 Début de la migration des données JSON vers Isar...');
    
    try {
      // 1. Charger et migrer les muscles
      await _migrateMuscles();
      
      // 2. Charger et migrer les exercices
      await _migrateExercises();
      
      // 3. Charger et migrer les programmes et sessions
      await _migrateProgramsAndSessions();
      
      print('✅ Migration terminée avec succès !');
      
    } catch (e) {
      print('❌ Erreur lors de la migration : $e');
      rethrow;
    }
  }
  
  /// Migre les muscles depuis muscles.json
  static Future<void> _migrateMuscles() async {
    print('📝 Migration des muscles...');
    
    final String jsonString = await rootBundle.loadString('assets/muscles.json');
    final Map<String, dynamic> json = jsonDecode(jsonString);
    
    final List<dynamic> musclesData = json['muscles'] as List<dynamic>;
    final List<Muscle> muscles = [];
    
    for (final muscleData in musclesData) {
      final muscle = Muscle.create(
        externalId: muscleData['id'] as String,
        name: muscleData['name'] as String,
        group: muscleData['group'] as String?, // Optionnel
      );
      muscles.add(muscle);
    }
    
    await IsarService.saveMuscles(muscles);
    print('✅ ${muscles.length} muscles migrés');
  }
  
  /// Migre les exercices depuis exercises.json
  static Future<void> _migrateExercises() async {
    print('📝 Migration des exercices...');
    
    final String jsonString = await rootBundle.loadString('assets/exercises.json');
    final Map<String, dynamic> json = jsonDecode(jsonString);
    
    final List<dynamic> exercisesData = json['exercises'] as List<dynamic>;
    final List<Exercise> exercises = [];
    
    for (final exerciseData in exercisesData) {
      final exercise = Exercise.create(
        externalId: exerciseData['id'] as String,
        name: exerciseData['name'] as String,
        notes: exerciseData['notes'] as String?,
        sets: exerciseData['sets'] as int?,
        restBetweenSetsSec: exerciseData['rest_between_sets_sec'] as int? ?? 90,
        restAfterExerciseSec: exerciseData['rest_after_exercise_sec'] as int? ?? 120,
        isIsometric: exerciseData['is_isometric'] as bool? ?? false,
        muscleIds: (exerciseData['muscles'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ?? [],
      );
      
      // Gestion des répétitions
      final reps = exerciseData['reps'];
      if (reps is int) {
        exercise.reps = reps;
      } else if (reps is Map<String, dynamic>) {
        exercise.repsMin = reps['min'] as int?;
        exercise.repsMax = reps['max'] as int?;
      }
      
      // Gestion des répétitions par côté
      exercise.repsPerSide = exerciseData['reps_per_side'] as int? ??
                           exerciseData['reps_per_leg'] as int? ??
                           exerciseData['reps_per_arm'] as int?;
      
      // Gestion de la durée
      final duration = exerciseData['duration_sec'];
      if (duration is int) {
        exercise.durationSec = duration;
      } else if (duration is Map<String, dynamic>) {
        exercise.durationMinSec = duration['min'] as int?;
        exercise.durationMaxSec = duration['max'] as int?;
      }
      
      exercises.add(exercise);
    }
    
    await IsarService.saveExercises(exercises);
    print('✅ ${exercises.length} exercices migrés');
  }
  
  /// Migre les programmes et sessions depuis programme.json
  static Future<void> _migrateProgramsAndSessions() async {
    print('📝 Migration des programmes...');
    
    final String jsonString = await rootBundle.loadString('assets/programme.json');
    final Map<String, dynamic> json = jsonDecode(jsonString);
    
    final Map<String, dynamic> programData = json['program'] as Map<String, dynamic>;
    
    // Créer le programme principal
    final program = Program.create(
      externalId: 'chaine_porteuse',
      name: programData['name'] as String,
      objective: programData['objective'] as String?,
      muscles: (programData['muscles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      goals: (programData['goals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
    );
    
    // Gérer sessions_per_week
    final sessionsPerWeek = programData['sessions_per_week'];
    if (sessionsPerWeek is List && sessionsPerWeek.isNotEmpty) {
      program.sessionsPerWeekMin = sessionsPerWeek[0] as int?;
      if (sessionsPerWeek.length > 1) {
        program.sessionsPerWeekMax = sessionsPerWeek[1] as int?;
      }
    }
    
    // Créer les sessions
    final List<dynamic> sessionsData = programData['sessions'] as List<dynamic>;
    final List<Session> sessions = [];
    final List<String> sessionIds = [];
    
    for (final sessionData in sessionsData) {
      final sessionId = 'session_${sessionData['id']}';
      sessionIds.add(sessionId);
      
      final session = Session.create(
        externalId: sessionId,
        name: sessionData['name'] as String,
        focus: sessionData['focus'] as String?,
        programId: 'chaine_porteuse',
      );
      
      // Extraire les IDs d'exercices de cette session
      final List<dynamic> exercisesData = sessionData['exercises'] as List<dynamic>;
      final List<String> exerciseIds = [];
      
      for (final exerciseData in exercisesData) {
        // L'exercice existe déjà avec son nom, on doit trouver son ID externe
        final exerciseName = exerciseData['name'] as String;
        final exerciseId = _getExerciseIdFromName(exerciseName);
        if (exerciseId != null) {
          exerciseIds.add(exerciseId);
        }
      }
      
      session.exerciseIds = exerciseIds;
      sessions.add(session);
    }
    
    program.sessionIds = sessionIds;
    
    await IsarService.saveProgramsAndSessions([program], sessions);
    print('✅ 1 programme et ${sessions.length} sessions migrés');
  }
  
  /// Convertit un nom d'exercice en ID externe (mapping basique)
  static String? _getExerciseIdFromName(String name) {
    final Map<String, String> nameToId = {
      'Scapula Pull-Ups': 'scapula_pull_ups',
      'Pompes scapulaires': 'pompes_scapulaires',
      'Row élastique bas': 'row_elastique_bas',
      'Face Pull (élastique)': 'face_pull_elastique',
      'Superman statique': 'superman_statique',
      'Planche bras tendus': 'planche_bras_tendus',
      'Good Morning élastique': 'good_morning_elastique',
      'Hip Thrust (bande)': 'hip_thrust_bande',
      'Kickbacks à genoux': 'kickbacks_genoux',
      'Fentes bulgares': 'fentes_bulgares',
      'Gainage latéral': 'gainage_lateral',
      'Superman pulse': 'superman_pulse',
      'Traction négative': 'traction_negative',
      'Row inversé': 'row_inverse',
      'Planche scapulaire dynamique': 'planche_scapulaire_dynamique',
      'Soulevé de terre élastique': 'souleve_terre_elastique',
      'Superman lent': 'superman_lent',
      'Dead Hang': 'dead_hang',
      'Cercles épaules / dislocations': 'cercles_epaules_dislocations',
      'Hanging passif': 'hanging_passif',
      'Pompes scapulaires (quadrupédie)': 'pompes_scapulaires_quadrupedie',
      'Bird-dog lent': 'bird_dog_lent',
      'Étirements ciblés': 'etirements_cibles',
    };
    
    return nameToId[name];
  }
}
