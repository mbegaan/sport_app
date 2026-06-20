import 'dart:convert';
import 'package:flutter/services.dart';
import 'isar_service.dart';
import '../models/muscle.dart';
import '../models/exercise.dart';
import '../models/program.dart';

/// Service pour migrer les données JSON vers Isar
class MigrationService {
  /// Effectue la migration complète depuis les fichiers JSON
  static Future<void> migrateFromJson() async {
    print('🔄 Début de la migration JSON vers Isar...');
    
    try {
      // Migration dans l'ordre des dépendances
      await _migrateMuscles();
      await _migrateExercises(); 
      await _migratePrograms();
      
      print('✅ Migration JSON vers Isar terminée avec succès');
    } catch (e) {
      print('❌ Erreur lors de la migration: $e');
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
      
      // Gestion des répétitions (int ou Map avec min/max)
      final reps = exerciseData['reps'];
      if (reps is int) {
        exercise.reps = reps;
      } else if (reps is Map<String, dynamic>) {
        exercise.repsMin = reps['min'] as int?;
        exercise.repsMax = reps['max'] as int?;
      }
      
      // Gestion des répétitions par côté/jambe/bras
      exercise.repsPerSide = exerciseData['reps_per_side'] as int?;
      exercise.repsPerLeg = exerciseData['reps_per_leg'] as int?;
      exercise.repsPerArm = exerciseData['reps_per_arm'] as int?;
      
      // Gestion de la durée (int ou Map avec min/max)
      final duration = exerciseData['duration_sec'];
      if (duration is int) {
        exercise.durationSec = duration;
      } else if (duration is Map<String, dynamic>) {
        exercise.durationMinSec = duration['min'] as int?;
        exercise.durationMaxSec = duration['max'] as int?;
      }
      
      // Durée par zone (pour les étirements)
      exercise.durationPerZoneSec = exerciseData['duration_per_zone_sec'] as int?;
      
      exercises.add(exercise);
    }
    
    await IsarService.saveExercises(exercises);
    print('✅ ${exercises.length} exercices migrés');
  }
  
  /// Migre les programmes depuis programme.json et chaine_porteuse.json
  static Future<void> _migratePrograms() async {
    print('📝 Migration des programmes...');
    
    // Charger le programme principal depuis programme.json
    await _migrateProgramFromFile('assets/programme.json');
    
    // Charger aussi le programme structuré depuis chaine_porteuse.json
    try {
      await _migrateProgramFromFile('assets/programmes/chaine_porteuse.json');
    } catch (e) {
      print('⚠️  Fichier chaine_porteuse.json non trouvé ou erreur: $e');
    }
    
    print('✅ Programmes migrés');
  }
  
  /// Migre un programme depuis un fichier JSON spécifique
  static Future<void> _migrateProgramFromFile(String assetPath) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> json = jsonDecode(jsonString);
    
    final programData = json['program'] as Map<String, dynamic>;
    
    // Créer le programme
    final program = Program.create(
      externalId: programData['id'] as String? ?? 'chaine_porteuse',
      name: programData['name'] as String,
      objective: programData['objective'] as String,
      muscles: (programData['muscles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      goals: (programData['goals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      sessionsPerWeek: (programData['sessions_per_week'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList() ?? [],
    );
    
    // Créer les sessions
    final List<Session> sessions = [];
    final sessionsList = programData['sessions'] as List<dynamic>;
    
    for (final sessionData in sessionsList) {
      final session = Session.create(
        externalId: _getSessionExternalId(sessionData),
        programId: program.externalId,
        name: sessionData['name'] as String,
        focus: sessionData['focus'] as String? ?? '',
        exerciseIds: _extractExerciseIds(sessionData),
      );
      sessions.add(session);
    }
    
    // Sauvegarder en base
    await IsarService.saveProgram(program);
    for (final session in sessions) {
      await IsarService.saveSession(session);
    }
    
    print('✅ Programme "${program.name}" migré avec ${sessions.length} sessions');
  }
  
  /// Extrait l'ID externe d'une session selon le format JSON
  static String _getSessionExternalId(Map<String, dynamic> sessionData) {
    // Format avec ID numérique (programme.json)
    if (sessionData['id'] is int) {
      return sessionData['id'].toString();
    }
    // Format avec ID string (chaine_porteuse.json)
    if (sessionData['id'] is String) {
      return sessionData['id'] as String;
    }
    // Fallback sur le nom en minuscules
    return (sessionData['name'] as String).toLowerCase().replaceAll(' ', '_');
  }
  
  /// Extrait la liste des IDs d'exercices selon le format JSON
  static List<String> _extractExerciseIds(Map<String, dynamic> sessionData) {
    final exercises = sessionData['exercises'] as List<dynamic>;
    final List<String> exerciseIds = [];
    
    for (final exercise in exercises) {
      if (exercise is Map<String, dynamic>) {
        // Format structuré (chaine_porteuse.json)
        if (exercise.containsKey('exercise_id')) {
          exerciseIds.add(exercise['exercise_id'] as String);
        }
        // Format avec exercice complet (programme.json)
        else if (exercise.containsKey('name')) {
          // Convertir le nom en ID (snake_case)
          final name = exercise['name'] as String;
          final id = name
              .toLowerCase()
              .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
              .replaceAll(RegExp(r'\s+'), '_');
          exerciseIds.add(id);
        }
      }
    }
    
    return exerciseIds;
  }
}
