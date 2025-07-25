import 'package:isar/isar.dart';

part 'program.g.dart';

@collection
class Program {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String externalId; // Correspond à l'id JSON
  
  late String name; // Nom du programme
  
  String? objective; // Objectif du programme
  
  List<String> muscles = <String>[]; // Muscles principaux ciblés
  
  List<String> goals = <String>[]; // Objectifs (stabilité, force, etc.)
  
  int? sessionsPerWeekMin; // Séances par semaine minimum
  int? sessionsPerWeekMax; // Séances par semaine maximum
  
  List<String> sessionIds = <String>[]; // IDs des sessions de ce programme
  
  Program();
  
  Program.create({
    required this.externalId,
    required this.name,
    this.objective,
    this.muscles = const <String>[],
    this.goals = const <String>[],
    this.sessionsPerWeekMin,
    this.sessionsPerWeekMax,
    this.sessionIds = const <String>[],
  });
  
  @override
  String toString() => 'Program(externalId: $externalId, name: $name)';
}

@collection
class Session {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String externalId; // ID unique de la session
  
  late String name; // Nom de la session
  
  String? focus; // Focus de la session (ex: "Scapulas + Tirage postural")
  
  late String programId; // ID du programme parent
  
  List<String> exerciseIds = <String>[]; // IDs des exercices dans l'ordre
  
  Session();
  
  Session.create({
    required this.externalId,
    required this.name,
    this.focus,
    required this.programId,
    this.exerciseIds = const <String>[],
  });
  
  @override
  String toString() => 'Session(externalId: $externalId, name: $name)';
}
