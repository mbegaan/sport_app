import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Mock complet de l'AssetBundle pour les tests
class MockBundle extends AssetBundle {
  final Map<String, String> _assets = {};
  final Map<String, Exception> _errors = {};
  
  /// Ajoute un asset au mock
  void addAsset(String key, String content) {
    _assets[key] = content;
    _errors.remove(key); // Supprimer toute erreur précédente pour cette clé
  }
  
  /// Configure une erreur pour un asset spécifique
  void setError(String key, Exception error) {
    _errors[key] = error;
    _assets.remove(key); // Supprimer le contenu s'il existe
  }
  
  /// Nettoie tous les assets et erreurs
  void clear() {
    _assets.clear();
    _errors.clear();
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    // Vérifier s'il y a une erreur configurée pour cette clé
    if (_errors.containsKey(key)) {
      throw _errors[key]!;
    }
    
    // Retourner le contenu s'il existe
    if (_assets.containsKey(key)) {
      return _assets[key]!;
    }
    
    // Sinon, lever une exception de fichier non trouvé
    throw FlutterError('Unable to load asset: $key');
  }
  
  @override
  Future<ByteData> load(String key) async {
    final string = await loadString(key);
    final bytes = string.codeUnits;
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }
  
  @override
  void evict(String key) {
    _assets.remove(key);
    _errors.remove(key);
  }
}
