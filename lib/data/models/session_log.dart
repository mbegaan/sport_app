import 'package:isar/isar.dart';

part 'session_log.g.dart';

/// Log d'une séance d'entraînement réalisée par l'utilisateur
@collection
class SessionLog {
  Id id = Isar.autoIncrement;
  
  late DateTime startTime; // Heure de début de la séance
  DateTime? endTime; // Heure de fin de la séance
  
  late String programId; // ID du programme utilisé
  late String sessionId; // ID de la session du programme
  late String sessionName; // Nom de la session (pour affichage)
  
  // Exercices réalisés dans cette séance
  List<ExerciseLog> exerciseLogs = <ExerciseLog>[];
  
  String? notes; // Notes générales sur la séance
  int? overallRpe; // RPE général de la séance (1-10)
  
  SessionLog();
  
  SessionLog.create({
    required this.startTime,
    this.endTime,
    required this.programId,
    required this.sessionId,
    required this.sessionName,
    this.exerciseLogs = const <ExerciseLog>[],
    this.notes,
    this.overallRpe,
  });
  
  /// Durée totale de la séance
  @ignore
  Duration? get duration {
    if (endTime == null) return null;
    return endTime!.difference(startTime);
  }
  
  /// Nombre total d'exercices réalisés
  @ignore
  int get totalExercises => exerciseLogs.length;
  
  /// Nombre total de séries réalisées
  @ignore
  int get totalSets => exerciseLogs.fold(0, (sum, exercise) => sum + exercise.sets.length);
  
  @override
  String toString() => 'SessionLog(sessionName: $sessionName, startTime: $startTime)';
}

/// Log d'un exercice dans une séance
@embedded
class ExerciseLog {
  late String exerciseId; // ID de l'exercice
  late String exerciseName; // Nom de l'exercice (pour affichage)
  
  List<SetLog> sets = <SetLog>[]; // Séries réalisées
  
  String? notes; // Notes spécifiques à l'exercice
  int? rpe; // RPE de l'exercice (1-10)
  
  ExerciseLog();
  
  ExerciseLog.create({
    required this.exerciseId,
    required this.exerciseName,
    this.sets = const <SetLog>[],
    this.notes,
    this.rpe,
  });
  
  @override
  String toString() => 'ExerciseLog(exerciseName: $exerciseName, sets: ${sets.length})';
}

/// Log d'une série d'un exercice
@embedded
class SetLog {
  int setNumber = 1; // Numéro de la série
  
  // Pour les exercices de répétitions
  int? reps; // Répétitions réalisées
  double? weight; // Poids utilisé (optionnel, pour futurs équipements)
  
  // Pour les exercices de durée
  int? durationSec; // Durée réalisée en secondes
  
  // Pour les exercices unilatéraux
  int? repsLeft; // Répétitions côté gauche
  int? repsRight; // Répétitions côté droit
  
  String? notes; // Notes sur cette série
  int? rpe; // RPE de cette série (1-10)
  
  bool completed = true; // Série complétée ou non
  
  SetLog();
  
  SetLog.create({
    required this.setNumber,
    this.reps,
    this.weight,
    this.durationSec,
    this.repsLeft,
    this.repsRight,
    this.notes,
    this.rpe,
    this.completed = true,
  });
  
  /// Obtient les répétitions totales (unilateral ou standard)
  @ignore
  int? get totalReps {
    if (reps != null) return reps;
    if (repsLeft != null && repsRight != null) return repsLeft! + repsRight!;
    return null;
  }
  
  @override
  String toString() => 'SetLog(setNumber: $setNumber, reps: $reps, duration: $durationSec)';
}
