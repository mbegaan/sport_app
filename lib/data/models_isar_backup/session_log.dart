import 'package:isar/isar.dart';

part 'session_log.g.dart';

@collection
class SessionLog {
  Id id = Isar.autoIncrement;
  
  late DateTime date; // Date et heure de la séance
  
  late String programId; // ID du programme utilisé
  late String sessionId; // ID de la session utilisée
  
  String? notes; // Notes générales de la séance
  
  int? duration; // Durée totale de la séance en secondes
  
  int? overallRpe; // RPE général de la séance (1-10)
  
  List<ExerciseLog> exercises = <ExerciseLog>[]; // Logs des exercices
  
  SessionLog();
  
  SessionLog.create({
    required this.date,
    required this.programId,
    required this.sessionId,
    this.notes,
    this.duration,
    this.overallRpe,
    this.exercises = const <ExerciseLog>[],
  });
  
  @override
  String toString() => 'SessionLog(date: $date, programId: $programId, sessionId: $sessionId)';
}

@embedded
class ExerciseLog {
  late String exerciseId; // ID de l'exercice
  
  String? notes; // Notes spécifiques à cet exercice
  
  int? rpe; // RPE pour cet exercice (1-10)
  
  List<SetLog> sets = <SetLog>[]; // Logs des séries
  
  ExerciseLog();
  
  ExerciseLog.create({
    required this.exerciseId,
    this.notes,
    this.rpe,
    this.sets = const <SetLog>[],
  });
  
  @override
  String toString() => 'ExerciseLog(exerciseId: $exerciseId, sets: ${sets.length})';
}

@embedded
class SetLog {
  int setNumber = 1; // Numéro de la série
  
  // Pour les exercices de répétitions
  int? reps; // Répétitions réalisées
  int? repsPerSide; // Répétitions par côté si applicable
  
  // Pour les exercices de durée
  int? durationSec; // Durée réalisée en secondes
  
  // Charge/résistance (optionnel pour le futur)
  String? weight; // Poids ou résistance utilisée
  
  // RPE de la série
  int? rpe; // RPE de cette série spécifique (1-10)
  
  String? notes; // Notes sur cette série
  
  SetLog();
  
  SetLog.create({
    this.setNumber = 1,
    this.reps,
    this.repsPerSide,
    this.durationSec,
    this.weight,
    this.rpe,
    this.notes,
  });
  
  @override
  String toString() => 'SetLog(setNumber: $setNumber, reps: $reps, duration: $durationSec)';
}
