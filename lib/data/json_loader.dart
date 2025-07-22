import 'dart:convert';
import 'package:flutter/services.dart';
import 'program_model.dart';
import '../utils/app_exceptions.dart';

/// Classe responsable du chargement du programme depuis le fichier JSON
class JsonLoader {
  static Program? _cachedProgram;
  static AssetBundle? _customBundle;

  /// Définit un AssetBundle personnalisé (utile pour les tests)
  static void setCustomBundle(AssetBundle? bundle) {
    _customBundle = bundle;
  }

  /// Obtient l'AssetBundle à utiliser (mock ou rootBundle)
  static AssetBundle get _bundle => _customBundle ?? rootBundle;

  /// Getter public pour les tests (accès au bundle utilisé)
  static AssetBundle get currentBundle => _bundle;

  /// Charge le programme depuis le fichier assets/programme.json
  static Future<Program> loadProgram() async {
    if (_cachedProgram != null) {
      return _cachedProgram!;
    }

    try {
      final String jsonString = await _bundle.loadString('assets/programme.json');
      
      late Map<String, dynamic> jsonData;
      try {
        jsonData = json.decode(jsonString);
      } catch (e) {
        throw DataParsingException(
          message: 'Erreur de format JSON',
          details: 'assets/programme.json',
          originalError: e,
        );
      }
      
      try {
        _cachedProgram = Program.fromJson(jsonData);
        return _cachedProgram!;
      } catch (e) {
        throw DataParsingException(
          message: 'Erreur de parsing du programme',
          details: 'Structure JSON invalide',
          originalError: e,
        );
      }
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw DataLoadingException(
        message: 'Erreur lors du chargement du programme',
        details: 'assets/programme.json',
        originalError: e,
      );
    }
  }

  /// Réinitialise le cache et le bundle personnalisé (utile pour les tests)
  static void clearCache() {
    _cachedProgram = null;
    _customBundle = null;
  }
}
