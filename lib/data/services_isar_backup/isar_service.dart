import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/muscle.dart';
import '../models/exercise.dart';
import '../models/program.dart';
import '../models/session_log.dart';

/// Service de base de données Isar centralisé
class IsarService {
  static Isar? _isar;
  
  /// Instance singleton de la base de données
  static Isar get instance {
    if (_isar == null) {
      throw Exception('IsarService not initialized. Call initialize() first.');
    }
    return _isar!;
  }
  
  /// Initialise la base de données Isar
  static Future<void> initialize() async {
    if (_isar != null) return; // Déjà initialisée
    
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
      name: 'sport_app',
    );
  }
  
  /// Ferme la base de données
  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
  
  /// Vérifie si la base de données contient des données
  static Future<bool> hasData() async {
    final muscleCount = await instance.muscles.count();
    final exerciseCount = await instance.exercises.count();
    final programCount = await instance.programs.count();
    
    return muscleCount > 0 && exerciseCount > 0 && programCount > 0;
  }
  
  /// Supprime toutes les données (pour tests ou reset)
  static Future<void> clearAll() async {
    await instance.writeTxn(() async {
      await instance.clear();
    });
  }
  
  // === MUSCLES ===
  
  /// Récupère tous les muscles
  static Future<List<Muscle>> getAllMuscles() async {
    return await instance.muscles.where().findAll();
  }
  
  /// Récupère un muscle par son ID externe
  static Future<Muscle?> getMuscleByExternalId(String externalId) async {
    return await instance.muscles
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Ajoute ou met à jour un muscle
  static Future<void> saveMuscle(Muscle muscle) async {
    await instance.writeTxn(() async {
      await instance.muscles.put(muscle);
    });
  }
  
  /// Ajoute plusieurs muscles en lot
  static Future<void> saveMuscles(List<Muscle> muscles) async {
    await instance.writeTxn(() async {
      await instance.muscles.putAll(muscles);
    });
  }
  
  // === EXERCISES ===
  
  /// Récupère tous les exercices
  static Future<List<Exercise>> getAllExercises() async {
    return await instance.exercises.where().findAll();
  }
  
  /// Récupère un exercice par son ID externe
  static Future<Exercise?> getExerciseByExternalId(String externalId) async {
    return await instance.exercises
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Ajoute ou met à jour un exercice
  static Future<void> saveExercise(Exercise exercise) async {
    await instance.writeTxn(() async {
      await instance.exercises.put(exercise);
    });
  }
  
  /// Ajoute plusieurs exercices en lot
  static Future<void> saveExercises(List<Exercise> exercises) async {
    await instance.writeTxn(() async {
      await instance.exercises.putAll(exercises);
    });
  }
  
  // === PROGRAMS & SESSIONS ===
  
  /// Récupère tous les programmes
  static Future<List<Program>> getAllPrograms() async {
    return await instance.programs.where().findAll();
  }
  
  /// Récupère un programme par son ID externe
  static Future<Program?> getProgramByExternalId(String externalId) async {
    return await instance.programs
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Récupère toutes les sessions d'un programme
  static Future<List<Session>> getSessionsByProgramId(String programId) async {
    return await instance.sessions
        .filter()
        .programIdEqualTo(programId)
        .findAll();
  }
  
  /// Récupère une session par son ID externe
  static Future<Session?> getSessionByExternalId(String externalId) async {
    return await instance.sessions
        .filter()
        .externalIdEqualTo(externalId)
        .findFirst();
  }
  
  /// Ajoute ou met à jour un programme
  static Future<void> saveProgram(Program program) async {
    await instance.writeTxn(() async {
      await instance.programs.put(program);
    });
  }
  
  /// Ajoute ou met à jour une session
  static Future<void> saveSession(Session session) async {
    await instance.writeTxn(() async {
      await instance.sessions.put(session);
    });
  }
  
  /// Ajoute plusieurs programmes et sessions en lot
  static Future<void> saveProgramsAndSessions(
    List<Program> programs,
    List<Session> sessions,
  ) async {
    await instance.writeTxn(() async {
      await instance.programs.putAll(programs);
      await instance.sessions.putAll(sessions);
    });
  }
  
  // === SESSION LOGS ===
  
  /// Ajoute un log de séance
  static Future<void> saveSessionLog(SessionLog log) async {
    await instance.writeTxn(() async {
      await instance.sessionLogs.put(log);
    });
  }
  
  /// Récupère tous les logs de séances, triés par date décroissante
  static Future<List<SessionLog>> getAllSessionLogs() async {
    return await instance.sessionLogs
        .where()
        .sortByDateDesc()
        .findAll();
  }
  
  /// Récupère les logs de séances pour un programme spécifique
  static Future<List<SessionLog>> getSessionLogsByProgram(String programId) async {
    return await instance.sessionLogs
        .filter()
        .programIdEqualTo(programId)
        .sortByDateDesc()
        .findAll();
  }
  
  /// Récupère les logs de séances dans une plage de dates
  static Future<List<SessionLog>> getSessionLogsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return await instance.sessionLogs
        .filter()
        .dateBetween(start, end)
        .sortByDateDesc()
        .findAll();
  }
  
  /// Compte le nombre total de séances effectuées
  static Future<int> getTotalSessionCount() async {
    return await instance.sessionLogs.count();
  }
  
  /// Supprime un log de séance
  static Future<void> deleteSessionLog(int id) async {
    await instance.writeTxn(() async {
      await instance.sessionLogs.delete(id);
    });
  }
}
