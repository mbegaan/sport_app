/// Modèles de données pour le programme d'entraînement
class Program {
  final String name;
  final String objective;
  final List<String> muscles;
  final List<String> goals;
  final List<int> sessionsPerWeek;
  final List<Session> sessions;
  final GeneralTips generalTips;

  const Program({
    required this.name,
    required this.objective,
    required this.muscles,
    required this.goals,
    required this.sessionsPerWeek,
    required this.sessions,
    required this.generalTips,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    final programData = json['program'] as Map<String, dynamic>;
    
    return Program(
      name: programData['name'] as String,
      objective: programData['objective'] as String,
      muscles: List<String>.from(programData['muscles'] as List),
      goals: List<String>.from(programData['goals'] as List),
      sessionsPerWeek: List<int>.from(programData['sessions_per_week'] as List),
      sessions: (programData['sessions'] as List)
          .map((s) => Session.fromJson(s as Map<String, dynamic>))
          .toList(),
      generalTips: GeneralTips.fromJson(programData['general_tips'] as Map<String, dynamic>),
    );
  }
}

class Session {
  final int id;
  final String name;
  final String focus;
  final List<Exercise> exercises;

  const Session({
    required this.id,
    required this.name,
    required this.focus,
    required this.exercises,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as int,
      name: json['name'] as String,
      focus: json['focus'] as String,
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Exercise {
  final String name;
  final dynamic sets; // int ou Map avec min/max
  final List<int>? reps; // pour min/max reps
  final int? repsPerLeg;
  final int? repsPerArm;
  final int? repsPerSide;
  final int? durationSec; // pour min/max duration
  final int? durationPerZoneSec;
  final int restSec;
  final String? notes;
  final String? equipment;

  const Exercise({
    required this.name,
    required this.sets,
    this.reps,
    this.repsPerLeg,
    this.repsPerArm,
    this.repsPerSide,
    this.durationSec,
    this.durationPerZoneSec,
    this.restSec = 60,
    this.notes,
    this.equipment,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    // Gestion des reps (peut être un Map avec min/max ou null)
    List<int>? reps;
    if (json['reps'] != null) {
      final repsData = json['reps'];
      if (repsData is Map<String, dynamic>) {
        reps = [repsData['min'] as int, repsData['max'] as int];
      }
    }

    // Gestion de la durée (peut être un Map avec min/max ou null)
    int? durationSec;
    if (json['duration_sec'] != null) {
      final durationData = json['duration_sec'];
      if (durationData is Map<String, dynamic>) {
        durationSec = durationData['min'] as int; // On prend le minimum par défaut
      } else if (durationData is int) {
        durationSec = durationData;
      }
    }

    return Exercise(
      name: json['name'] as String,
      sets: json['sets'],
      reps: reps,
      repsPerLeg: json['reps_per_leg'] as int?,
      repsPerArm: json['reps_per_arm'] as int?,
      repsPerSide: json['reps_per_side'] as int?,
      durationSec: durationSec,
      durationPerZoneSec: json['duration_per_zone_sec'] as int?,
      notes: json['notes'] as String?,
      equipment: json['equipment'] as String?,
    );
  }

  /// Retourne le nombre de séries à effectuer
  int get numberOfSets {
    if (sets is int) return sets as int;
    if (sets is Map<String, dynamic>) {
      return (sets as Map<String, dynamic>)['min'] as int;
    }
    return 1;
  }

  /// Retourne le nombre de répétitions à effectuer
  int? get numberOfReps {
    if (reps != null) return reps![0]; // min
    if (repsPerLeg != null) return repsPerLeg;
    if (repsPerArm != null) return repsPerArm;
    if (repsPerSide != null) return repsPerSide;
    return null;
  }

  /// Retourne la durée de l'exercice en secondes
  int? get exerciseDuration {
    return durationSec ?? durationPerZoneSec;
  }

  /// Indique si c'est un exercice de durée (plutôt que de répétitions)
  bool get isDurationBased {
    return exerciseDuration != null;
  }
}

class GeneralTips {
  final Map<String, int> tempo;
  final List<int> restBetweenSets;
  final int? restOnTractions;
  final String breathing;
  final String journaling;

  const GeneralTips({
    required this.tempo,
    required this.restBetweenSets,
    this.restOnTractions,
    required this.breathing,
    required this.journaling,
  });

  factory GeneralTips.fromJson(Map<String, dynamic> json) {
    final restData = json['rest_between_sets_sec'] as Map<String, dynamic>;
    
    return GeneralTips(
      tempo: Map<String, int>.from(json['tempo'] as Map),
      restBetweenSets: [restData['min'] as int, restData['max'] as int],
      restOnTractions: json['rest_on_tractions_max_sec'] as int?,
      breathing: json['breathing'] as String,
      journaling: json['journaling'] as String,
    );
  }
}
