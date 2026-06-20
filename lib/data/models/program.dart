import 'package:isar/isar.dart';

part 'program.g.dart';

@collection
class Program {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String externalId; // ID externe du programme (ex: "chaine_porteuse")
  
  late String name; // Nom du programme
  late String objective; // Objectif du programme
  
  List<String> muscles = <String>[]; // Muscles ciblés
  List<String> goals = <String>[]; // Objectifs
  List<int> sessionsPerWeek = <int>[]; // Sessions par semaine [min, max]
  
  Program();
  
  Program.create({
    required this.externalId,
    required this.name,
    required this.objective,
    this.muscles = const <String>[],
    this.goals = const <String>[],
    this.sessionsPerWeek = const <int>[],
  });
  
  @override
  String toString() => 'Program(externalId: $externalId, name: $name)';
}

@collection
class Session {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String externalId; // ID externe de la session (ex: "structure")
  
  late String programId; // ID du programme parent
  late String name; // Nom de la session
  late String focus; // Focus de la session
  
  List<String> exerciseIds = <String>[]; // IDs des exercices dans l'ordre
  
  Session();
  
  Session.create({
    required this.externalId,
    required this.programId,
    required this.name,
    required this.focus,
    this.exerciseIds = const <String>[],
  });
  
  @override
  String toString() => 'Session(externalId: $externalId, name: $name)';
}
