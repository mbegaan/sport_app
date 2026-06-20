import 'package:isar/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String externalId; // Correspond à l'id JSON (ex: "scapula_pull_ups")
  
  late String name; // Nom de l'exercice
  
  String? notes; // Notes d'exécution
  
  // Configuration des séries et répétitions
  int? sets; // Nombre de séries
  
  // Répétitions (peut être un nombre fixe ou une plage min/max)
  int? reps; // Nombre fixe de répétitions
  int? repsMin; // Répétitions minimum
  int? repsMax; // Répétitions maximum
  
  // Pour les exercices unilatéraux
  int? repsPerSide; // Répétitions par côté (ex: fentes)
  int? repsPerLeg; // Alias pour repsPerSide
  int? repsPerArm; // Répétitions par bras
  
  // Durée pour les exercices isométriques
  int? durationSec; // Durée fixe en secondes
  int? durationMinSec; // Durée minimum
  int? durationMaxSec; // Durée maximum
  int? durationPerZoneSec; // Durée par zone (étirements)
  
  // Temps de repos
  int restBetweenSetsSec = 90; // Repos entre séries
  int restAfterExerciseSec = 120; // Repos après l'exercice
  
  // Flags
  bool isIsometric = false; // Exercice statique
  
  // Relations
  List<String> muscleIds = <String>[]; // IDs des muscles ciblés
  
  Exercise();
  
  Exercise.create({
    required this.externalId,
    required this.name,
    this.notes,
    this.sets,
    this.reps,
    this.repsMin,
    this.repsMax,
    this.repsPerSide,
    this.repsPerLeg,
    this.repsPerArm,
    this.durationSec,
    this.durationMinSec,
    this.durationMaxSec,
    this.durationPerZoneSec,
    this.restBetweenSetsSec = 90,
    this.restAfterExerciseSec = 120,
    this.isIsometric = false,
    this.muscleIds = const <String>[],
  });
  
  // Méthodes helper
  bool get isDurationBased => durationSec != null || 
      (durationMinSec != null && durationMaxSec != null) ||
      durationPerZoneSec != null;
  
  bool get hasRepsRange => repsMin != null && repsMax != null;
  
  bool get hasDurationRange => durationMinSec != null && durationMaxSec != null;
  
  bool get isUnilateral => repsPerSide != null || repsPerLeg != null || repsPerArm != null;
  
  // Obtenir le nombre de répétitions à afficher
  @ignore
  int? get displayReps {
    if (reps != null) return reps;
    if (hasRepsRange) return repsMax; // Afficher le max par défaut
    if (repsPerSide != null) return repsPerSide;
    if (repsPerLeg != null) return repsPerLeg;
    if (repsPerArm != null) return repsPerArm;
    return null;
  }
  
  // Obtenir la durée à afficher
  @ignore
  int? get displayDuration {
    if (durationSec != null) return durationSec;
    if (hasDurationRange) return durationMaxSec; // Afficher le max par défaut
    if (durationPerZoneSec != null) return durationPerZoneSec;
    return null;
  }
  
  @override
  String toString() => 'Exercise(externalId: $externalId, name: $name)';
}
