import '../models/muscle.dart';
import '../models/exercise.dart';
import '../models/program.dart';
import '../models/session_log.dart';
import 'isar_service.dart';
import 'migration_service.dart';
import '../../utils/app_exceptions.dart';

/// Service unifié pour accéder aux données depuis Isar
/// Remplace JsonLoader pour une approche base de données
class DataService {
  static bool _initialized = false;
  
  /// Initialise le service de données
  /// Effectue la migration depuis JSON si c'est le premier lancement
  static Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      // Initialiser Isar
      await IsarService.initialize();
      
      // Vérifier si on a déjà des données
      if (!await IsarService.hasData()) {
        print('🔄 Première utilisation détectée, migration des données JSON...');
        await MigrationService.migrateFromJson();
      }
      
      _initialized = true;
      print('✅ DataService initialisé');
      
    } catch (e) {
      throw DataLoadingException(
        message: 'Erreur lors de l\'initialisation des données',
        originalError: e,
      );
    }
  }
  
  // === RÉCUPÉRATION DES DONNÉES (remplace JsonLoader) ===
  
  /// Récupère le programme principal avec ses sessions
  /// Équivalent à JsonLoader.loadProgram()
  static Future<ProgramData> loadProgram() async {
    await _ensureInitialized();
    
    try {
      // Récupérer le programme principal (Chaîne Porteuse)
      final program = await IsarService.getProgramByExternalId('chaine_porteuse');
      if (program == null) {
        throw const NotFoundException(message: 'Programme principal non trouvé');
      }
      
      // Récupérer toutes les sessions du programme
      final sessions = await IsarService.getSessionsByProgramId('chaine_porteuse');
      
      // Convertir en format compatible avec l'UI existante
      return ProgramData(
        name: program.name,
        objective: program.objective,
        muscles: program.muscles,
        goals: program.goals,
        sessionsPerWeek: program.sessionsPerWeek.isNotEmpty 
            ? program.sessionsPerWeek 
            : [2, 3],
        sessions: await _convertSessionsToSessionData(sessions),
      );
      
    } catch (e) {
      if (e is AppException) rethrow;
      throw DataParsingException(
        message: 'Erreur lors du chargement du programme',
        originalError: e,
      );
    }
  }
  
  /// Récupère une session spécifique avec ses exercices
  static Future<SessionData> getSession(String sessionId) async {
    await _ensureInitialized();
    
    try {
      final session = await IsarService.getSessionByExternalId(sessionId);
      if (session == null) {
        throw NotFoundException(message: 'Session non trouvée : $sessionId');
      }
      
      return await _convertSessionToSessionData(session);
      
    } catch (e) {
      if (e is AppException) rethrow;
      throw DataParsingException(
        message: 'Erreur lors du chargement de la session',
        originalError: e,
      );
    }
  }
  
  /// Récupère tous les muscles disponibles
  static Future<List<Muscle>> getAllMuscles() async {
    await _ensureInitialized();
    return await IsarService.getAllMuscles();
  }
  
  /// Récupère tous les exercices disponibles
  static Future<List<Exercise>> getAllExercises() async {
    await _ensureInitialized();
    return await IsarService.getAllExercises();
  }
  
  // === GESTION DES LOGS DE SÉANCES ===
  
  /// Enregistre un log de séance terminée
  static Future<void> logWorkoutSession({
    required String programId,
    required String sessionId,
    required String sessionName,
    required List<ExerciseLogData> exercises,
    DateTime? startTime,
    DateTime? endTime,
    String? notes,
    int? overallRpe,
  }) async {
    await _ensureInitialized();
    
    try {
      final sessionLog = SessionLog.create(
        startTime: startTime ?? DateTime.now(),
        endTime: endTime,
        programId: programId,
        sessionId: sessionId,
        sessionName: sessionName,
        notes: notes,
        overallRpe: overallRpe,
        exerciseLogs: exercises.map((e) => ExerciseLog.create(
          exerciseId: e.exerciseId,
          exerciseName: e.exerciseName,
          notes: e.notes,
          rpe: e.rpe,
          sets: e.sets.map((s) => SetLog.create(
            setNumber: s.setNumber,
            reps: s.reps,
            repsLeft: s.repsLeft,
            repsRight: s.repsRight,
            durationSec: s.durationSec,
            weight: s.weight,
            rpe: s.rpe,
            notes: s.notes,
          )).toList(),
        )).toList(),
      );
      
      await IsarService.saveSessionLog(sessionLog);
      
    } catch (e) {
      throw DataParsingException(
        message: 'Erreur lors de l\'enregistrement de la séance',
        originalError: e,
      );
    }
  }
  
  /// Récupère l'historique des séances
  static Future<List<SessionLog>> getWorkoutHistory({
    String? programId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await _ensureInitialized();
    
    try {
      if (programId != null) {
        return await IsarService.getSessionLogsByProgram(programId);
      } else if (startDate != null && endDate != null) {
        return await IsarService.getSessionLogsByDateRange(startDate, endDate);
      } else {
        return await IsarService.getAllSessionLogs();
      }
    } catch (e) {
      throw DataParsingException(
        message: 'Erreur lors du chargement de l\'historique',
        originalError: e,
      );
    }
  }
  
  /// Récupère les statistiques générales
  static Future<WorkoutStats> getWorkoutStats() async {
    await _ensureInitialized();
    
    try {
      final allLogs = await IsarService.getAllSessionLogs();
      final totalSessions = allLogs.length;
      
      final now = DateTime.now();
      final thirtyDaysAgo = now.subtract(const Duration(days: 30));
      final recentLogs = allLogs.where((log) => 
        log.startTime.isAfter(thirtyDaysAgo)
      ).toList();
      
      return WorkoutStats(
        totalSessions: totalSessions,
        sessionsThisMonth: recentLogs.length,
        averageSessionDuration: _calculateAverageSessionDuration(recentLogs),
        lastWorkoutDate: allLogs.isNotEmpty ? allLogs.first.startTime : null,
      );
      
    } catch (e) {
      throw DataParsingException(
        message: 'Erreur lors du calcul des statistiques',
        originalError: e,
      );
    }
  }
  
  // === MÉTHODES PRIVÉES ===
  
  static Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }
  
  /// Convertit les sessions Isar en SessionData pour l'UI
  static Future<List<SessionData>> _convertSessionsToSessionData(List<Session> sessions) async {
    final List<SessionData> sessionDataList = [];
    
    for (final session in sessions) {
      final sessionData = await _convertSessionToSessionData(session);
      sessionDataList.add(sessionData);
    }
    
    return sessionDataList;
  }
  
  /// Convertit une session Isar en SessionData
  static Future<SessionData> _convertSessionToSessionData(Session session) async {
    final List<ExerciseData> exerciseDataList = [];
    
    for (final exerciseId in session.exerciseIds) {
      final exercise = await IsarService.getExerciseByExternalId(exerciseId);
      if (exercise != null) {
        exerciseDataList.add(_convertExerciseToExerciseData(exercise));
      }
    }
    
    return SessionData(
      id: session.externalId,
      name: session.name,
      focus: session.focus,
      exercises: exerciseDataList,
    );
  }
  
  /// Convertit un exercice Isar en ExerciseData
  static ExerciseData _convertExerciseToExerciseData(Exercise exercise) {
    return ExerciseData(
      name: exercise.name,
      sets: exercise.sets ?? 1,
      reps: exercise.reps,
      repsMin: exercise.repsMin,
      repsMax: exercise.repsMax,
      repsPerSide: exercise.repsPerSide,
      durationSec: exercise.durationSec,
      durationMinSec: exercise.durationMinSec,
      durationMaxSec: exercise.durationMaxSec,
      notes: exercise.notes ?? '',
      restBetweenSetsSec: exercise.restBetweenSetsSec,
      restAfterExerciseSec: exercise.restAfterExerciseSec,
      isIsometric: exercise.isIsometric,
      muscleIds: exercise.muscleIds,
    );
  }
  
  /// Calcule la durée moyenne des séances en secondes
  static int? _calculateAverageSessionDuration(List<SessionLog> logs) {
    final durationsWithData = logs
        .where((log) => log.duration != null)
        .map((log) => log.duration!.inSeconds)
        .toList();
    
    if (durationsWithData.isEmpty) return null;
    
    return durationsWithData.reduce((a, b) => a + b) ~/ durationsWithData.length;
  }
}

// === CLASSES DE DONNÉES POUR L'UI ===

/// Structure de données compatible avec l'UI existante
class ProgramData {
  final String name;
  final String objective;
  final List<String> muscles;
  final List<String> goals;
  final List<int> sessionsPerWeek;
  final List<SessionData> sessions;
  
  ProgramData({
    required this.name,
    required this.objective,
    required this.muscles,
    required this.goals,
    required this.sessionsPerWeek,
    required this.sessions,
  });
}

class SessionData {
  final String id;
  final String name;
  final String focus;
  final List<ExerciseData> exercises;
  
  SessionData({
    required this.id,
    required this.name,
    required this.focus,
    required this.exercises,
  });
}

class ExerciseData {
  final String name;
  final int sets;
  final int? reps;
  final int? repsMin;
  final int? repsMax;
  final int? repsPerSide;
  final int? durationSec;
  final int? durationMinSec;
  final int? durationMaxSec;
  final String notes;
  final int restBetweenSetsSec;
  final int restAfterExerciseSec;
  final bool isIsometric;
  final List<String> muscleIds;
  
  ExerciseData({
    required this.name,
    required this.sets,
    this.reps,
    this.repsMin,
    this.repsMax,
    this.repsPerSide,
    this.durationSec,
    this.durationMinSec,
    this.durationMaxSec,
    required this.notes,
    required this.restBetweenSetsSec,
    required this.restAfterExerciseSec,
    required this.isIsometric,
    required this.muscleIds,
  });
  
  /// Getter pour la compatibilité avec l'UI existante
  bool get isDurationBased => durationSec != null || durationMinSec != null;
}

/// Structure pour l'enregistrement des logs de séance
class ExerciseLogData {
  final String exerciseId;
  final String exerciseName; // Nom de l'exercice pour affichage
  final String? notes;
  final int? rpe;
  final List<SetLogData> sets;
  
  ExerciseLogData({
    required this.exerciseId,
    required this.exerciseName,
    this.notes,
    this.rpe,
    required this.sets,
  });
}

class SetLogData {
  final int setNumber;
  final int? reps;
  final int? repsLeft;  // Pour exercices unilatéraux
  final int? repsRight; // Pour exercices unilatéraux  
  final int? durationSec;
  final double? weight; // Type correct pour le poids
  final int? rpe;
  final String? notes;
  
  SetLogData({
    required this.setNumber,
    this.reps,
    this.repsLeft,
    this.repsRight,
    this.durationSec,
    this.weight,
    this.rpe,
    this.notes,
  });
}

/// Statistiques de séances
class WorkoutStats {
  final int totalSessions;
  final int sessionsThisMonth;
  final int? averageSessionDuration;
  final DateTime? lastWorkoutDate;
  
  WorkoutStats({
    required this.totalSessions,
    required this.sessionsThisMonth,
    this.averageSessionDuration,
    this.lastWorkoutDate,
  });
}
