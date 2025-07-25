import 'package:isar/isar.dart';

part 'muscle.g.dart';

@collection
class Muscle {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String externalId; // Correspond à l'id JSON (ex: "trap_inf")
  
  late String name; // Nom complet (ex: "Trapèze inférieur")
  
  String? group; // Groupe musculaire (ex: "dos", "jambes")
  
  Muscle();
  
  Muscle.create({
    required this.externalId,
    required this.name,
    this.group,
  });
  
  @override
  String toString() => 'Muscle(externalId: $externalId, name: $name)';
}
