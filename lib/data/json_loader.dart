import 'dart:convert';
import 'package:flutter/services.dart';
import 'program_model.dart';

/// Classe responsable du chargement du programme depuis le fichier JSON
class JsonLoader {
  static Program? _cachedProgram;

  /// Charge le programme depuis le fichier assets/programme.json
  static Future<Program> loadProgram() async {
    if (_cachedProgram != null) {
      return _cachedProgram!;
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/programme.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      _cachedProgram = Program.fromJson(jsonData);
      return _cachedProgram!;
    } catch (e) {
      throw Exception('Erreur lors du chargement du programme: $e');
    }
  }

  /// Réinitialise le cache (utile pour les tests)
  static void clearCache() {
    _cachedProgram = null;
  }
}
