import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/muscle.dart';
import '../models/exercise.dart';
import '../models/program.dart';
import '../models/session_log.dart';

/// Service principal pour gérer la base de données Isar
class IsarService {
  static late Isar _isar;
  static bool _initialized = false;
  
  /// Obtient l'instance Isar
  static Isar get instance {
    if (!_initialized) {
      throw Exception('IsarService non initialisé. Appelez initialize() d\'abord.');
    }
    return _isar;
  }
  
  /// Initialise la base de données Isar
  static Future<void> initialize() async {
    if (_initialized) return;
    
    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [
        MuscleSchema,
        ExerciseSchema,
        ProgramSchema,
        SessionSchema,
        SessionLogSchema,
      ],
      directory: dir.path,
      name: 'sport_app_db',
    );
    
    _initialized = true;
  }
  
  /// Ferme la base de données
  static Future<void> close() async {
    if (_initialized) {
      await _isar.close();
      _initialized = false;
    }
  }
  
  /// Vérifie si on a déjà des données (pour migration initiale)
  static Future<bool> hasData() async {
    final muscleCount = await _isar.muscles.count();
    final exerciseCount = await _isar.exercises.count();
    final programCount = await _isar.programs.count();
    
    return muscleCount > 0 && exerciseCount > 0 && programCount > 0;
  }
  
  /// Supprime toutes les données (pour tests ou reset)
  static Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }
  
  // === MUSCLES ===
  
  /// Récupère tous les muscles
  static Future<List<Muscle>> getAllMuscles() async {
    return await _isar.muscles.where().findAll();
  }
  
  /// Récupère un muscle par son ID externe
  static Future<Muscle?> getMuscleByExternalId(String externalId) async {
    return await _isar.muscles
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Ajoute ou met à jour un muscle
  static Future<void> saveMuscle(Muscle muscle) async {
    await _isar.writeTxn(() async {
      await _isar.muscles.put(muscle);
    });
  }
  
  /// Ajoute plusieurs muscles en lot
  static Future<void> saveMuscles(List<Muscle> muscles) async {
    await _isar.writeTxn(() async {
      await _isar.muscles.putAll(muscles);
    });
  }
  
  // === EXERCISES ===
  
  /// Récupère tous les exercices
  static Future<List<Exercise>> getAllExercises() async {
    return await _isar.exercises.where().findAll();
  }
  
  /// Récupère un exercice par son ID externe
  static Future<Exercise?> getExerciseByExternalId(String externalId) async {
    return await _isar.exercises
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Récupère plusieurs exercices par leurs IDs externes
  static Future<List<Exercise>> getExercisesByExternalIds(List<String> externalIds) async {
    return await _isar.exercises
        .filter()
        .anyOf(externalIds, (q, externalId) => q.externalIdEqualTo(externalId))
        .findAll();
  }
  
  /// Ajoute ou met à jour un exercice
  static Future<void> saveExercise(Exercise exercise) async {
    await _isar.writeTxn(() async {
      await _isar.exercises.put(exercise);
    });
  }
  
  /// Ajoute plusieurs exercices en lot
  static Future<void> saveExercises(List<Exercise> exercises) async {
    await _isar.writeTxn(() async {
      await _isar.exercises.putAll(exercises);
    });
  }
  
  // === PROGRAMS & SESSIONS ===
  
  /// Récupère tous les programmes
  static Future<List<Program>> getAllPrograms() async {
    return await _isar.programs.where().findAll();
  }
  
  /// Récupère un programme par son ID externe
  static Future<Program?> getProgramByExternalId(String externalId) async {
    return await _isar.programs
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Récupère toutes les sessions d'un programme
  static Future<List<Session>> getSessionsByProgramId(String programId) async {
    return await _isar.sessions
        .filter()
        .programIdEqualTo(programId)
        .findAll();
  }
  
  /// Récupère une session par son ID externe
  static Future<Session?> getSessionByExternalId(String externalId) async {
    return await _isar.sessions
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Ajoute ou met à jour un programme
  static Future<void> saveProgram(Program program) async {
    await _isar.writeTxn(() async {
      await _isar.programs.put(program);
    });
  }
  
  /// Ajoute ou met à jour une session
  static Future<void> saveSession(Session session) async {
    await _isar.writeTxn(() async {
      await _isar.sessions.put(session);
    });
  }
  
  /// Ajoute plusieurs programmes et sessions en lot
  static Future<void> saveProgramsAndSessions(
    List<Program> programs, 
    List<Session> sessions,
  ) async {
    await _isar.writeTxn(() async {
      await _isar.programs.putAll(programs);
      await _isar.sessions.putAll(sessions);
    });
  }
  
  // === SESSION LOGS (HISTORIQUE) ===
  
  /// Sauvegarde un log de séance
  static Future<void> saveSessionLog(SessionLog sessionLog) async {
    await _isar.writeTxn(() async {
      await _isar.sessionLogs.put(sessionLog);
    });
  }
  
  /// Récupère tous les logs de séance, triés par date décroissante
  static Future<List<SessionLog>> getAllSessionLogs() async {
    return await _isar.sessionLogs
        .where()
        .sortByStartTimeDesc()
        .findAll();
  }
  
  /// Récupère les logs de séance par programme
  static Future<List<SessionLog>> getSessionLogsByProgram(String programId) async {
    return await _isar.sessionLogs
        .filter()
        .programIdEqualTo(programId)
        .sortByStartTimeDesc()
        .findAll();
  }
  
  /// Récupère les logs de séance par période
  static Future<List<SessionLog>> getSessionLogsByDateRange(
    DateTime startDate, 
    DateTime endDate,
  ) async {
    return await _isar.sessionLogs
        .filter()
        .startTimeBetween(startDate, endDate)
        .sortByStartTimeDesc()
        .findAll();
  }
  
  /// Récupère un log de séance par ID
  static Future<SessionLog?> getSessionLogById(Id id) async {
    return await _isar.sessionLogs.get(id);
  }
  
  /// Supprime un log de séance
  static Future<bool> deleteSessionLog(Id id) async {
    return await _isar.writeTxn(() async {
      return await _isar.sessionLogs.delete(id);
    });
  }
  
  /// Récupère les statistiques de base
  static Future<Map<String, dynamic>> getBasicStats() async {
    final totalSessions = await _isar.sessionLogs.count();
    final completedSessions = await _isar.sessionLogs
        .filter()
        .endTimeIsNotNull()
        .count();
    
    if (totalSessions == 0) {
      return {
        'totalSessions': 0,
        'completedSessions': 0,
        'averageDurationMinutes': 0,
        'lastSessionDate': null,
      };
    }
    
    final lastSession = await _isar.sessionLogs
        .where()
        .sortByStartTimeDesc()
        .findFirst();
    
    // Calculer la durée moyenne des séances complétées
    final completedSessionsWithDuration = await _isar.sessionLogs
        .filter()
        .endTimeIsNotNull()
        .findAll();
    
    double averageDurationMinutes = 0;
    if (completedSessionsWithDuration.isNotEmpty) {
      final totalMinutes = completedSessionsWithDuration
          .map((s) => s.duration?.inMinutes ?? 0)
          .fold(0, (sum, minutes) => sum + minutes);
      averageDurationMinutes = totalMinutes / completedSessionsWithDuration.length;
    }
    
    return {
      'totalSessions': totalSessions,
      'completedSessions': completedSessions,
      'averageDurationMinutes': averageDurationMinutes.round(),
      'lastSessionDate': lastSession?.startTime,
    };
  }
}
