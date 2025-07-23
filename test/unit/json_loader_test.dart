import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sport_app/data/json_loader.dart';

// Mock complet de l'AssetBundle pour les tests
class MockAssetBundle extends AssetBundle {
  final Map<String, String> _assets = {};
  
  void addAsset(String key, String content) {
    _assets[key] = content;
  }
  
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (_assets.containsKey(key)) {
      return _assets[key]!;
    }
    throw FlutterError('Asset not found: $key');
  }
  
  @override
  Future<ByteData> load(String key) async {
    final string = await loadString(key);
    final List<int> bytes = string.codeUnits;
    final Uint8List uint8List = Uint8List.fromList(bytes);
    return ByteData.view(uint8List.buffer);
  }
  
  @override
  void evict(String key) {
    _assets.remove(key);
  }
}

void main() {
  group('JsonLoader', () {
    late MockAssetBundle mockBundle;
    
    setUp(() {
      // Nettoyer le cache avant chaque test
      JsonLoader.clearCache();
      mockBundle = MockAssetBundle();
    });

    tearDown(() {
      JsonLoader.clearCache();
    });

    group('Chargement réussi', () {
      test('doit charger et parser le programme depuis les assets', () async {
        // Given: Un fichier JSON valide dans les assets mock
        const validJson = '''
        {
          "program": {
            "name": "Test Program",
            "objective": "Test objective",
            "muscles": ["muscle1", "muscle2"],
            "goals": ["goal1", "goal2"],
            "sessions_per_week": [2, 3],
            "sessions": [
              {
                "id": 1,
                "name": "Test Session",
                "focus": "Test focus",
                "exercises": [
                  {
                    "name": "Test Exercise",
                    "sets": 3,
                    "reps": {"min": 8, "max": 12},
                    "notes": "Test notes"
                  }
                ]
              }
            ],
            "general_tips": {
              "tempo": {"eccentric": 2, "pause": 1, "concentric": 2},
              "rest_between_sets_sec": {"min": 60, "max": 90},
              "breathing": "Test breathing",
              "journaling": "Test journaling"
            }
          }
        }
        ''';

        // When: Configuration du mock et chargement
        mockBundle.addAsset('assets/programme.json', validJson);
        JsonLoader.setCustomBundle(mockBundle);
        final program = await JsonLoader.loadProgram();

        // Then: le programme doit être correctement parsé
        expect(program.name, 'Test Program');
        expect(program.objective, 'Test objective');
        expect(program.muscles, contains('muscle1'));
        expect(program.sessions, hasLength(1));
        expect(program.sessions.first.name, 'Test Session');
        expect(program.sessions.first.exercises, hasLength(1));
        expect(program.sessions.first.exercises.first.name, 'Test Exercise');
      });

      test('doit utiliser le cache lors des appels suivants', () async {
        // Given: Un programme déjà chargé avec le mock
        const validJson = '''
        {
          "program": {
            "name": "Cached Program",
            "objective": "Test",
            "muscles": [],
            "goals": [],
            "sessions_per_week": [2],
            "sessions": [],
            "general_tips": {
              "tempo": {"eccentric": 2, "pause": 1, "concentric": 2},
              "rest_between_sets_sec": {"min": 60, "max": 90},
              "breathing": "Test",
              "journaling": "Test"
            }
          }
        }
        ''';

        mockBundle.addAsset('assets/programme.json', validJson);
        JsonLoader.setCustomBundle(mockBundle);

        // When: on charge deux fois le programme
        final program1 = await JsonLoader.loadProgram();
        final program2 = await JsonLoader.loadProgram();

        // Then: les deux références doivent être identiques (cache)
        expect(identical(program1, program2), true);
        expect(program1.name, 'Cached Program');
      });
    });

    group('Gestion des erreurs', () {
      test('doit lever une exception si le fichier n\'existe pas', () async {
        // Given: Aucun asset configuré dans le mock
        JsonLoader.setCustomBundle(mockBundle);

        // When & Then: Le chargement doit lever une exception
        expect(
          () => JsonLoader.loadProgram(),
          throwsA(isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Erreur lors du chargement du programme'),
          )),
        );
      });

      test('doit lever une exception si le JSON est mal formé', () async {
        // Given: Un JSON invalide
        const invalidJson = '{ "program": { "name": "Test", "invalid_json": } }';
        
        mockBundle.addAsset('assets/programme.json', invalidJson);
        JsonLoader.setCustomBundle(mockBundle);

        // When & Then: Le chargement doit lever une DataParsingException
        expect(
          () => JsonLoader.loadProgram(),
          throwsA(isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Erreur de format JSON'),
          )),
        );
      });
    });

    group('Cache management', () {
      test('clearCache doit vider le cache', () async {
        // Given: Un programme chargé
        const validJson = '''
        {
          "program": {
            "name": "Program to Clear",
            "objective": "Test",
            "muscles": [],
            "goals": [],
            "sessions_per_week": [2],
            "sessions": [],
            "general_tips": {
              "tempo": {"eccentric": 2, "pause": 1, "concentric": 2},
              "rest_between_sets_sec": {"min": 60, "max": 90},
              "breathing": "Test",
              "journaling": "Test"
            }
          }
        }
        ''';

        mockBundle.addAsset('assets/programme.json', validJson);
        JsonLoader.setCustomBundle(mockBundle);
        
        final program1 = await JsonLoader.loadProgram();

        // When: on vide le cache et charge un nouveau JSON
        JsonLoader.clearCache();
        
        const newValidJson = '''
        {
          "program": {
            "name": "New Program",
            "objective": "Test",
            "muscles": [],
            "goals": [],
            "sessions_per_week": [2],
            "sessions": [],
            "general_tips": {
              "tempo": {"eccentric": 2, "pause": 1, "concentric": 2},
              "rest_between_sets_sec": {"min": 60, "max": 90},
              "breathing": "Test",
              "journaling": "Test"
            }
          }
        }
        ''';
        
        mockBundle.addAsset('assets/programme.json', newValidJson);
        JsonLoader.setCustomBundle(mockBundle);
        final program2 = await JsonLoader.loadProgram();

        // Then: les programmes doivent être différents
        expect(program1.name, 'Program to Clear');
        expect(program2.name, 'New Program');
        expect(identical(program1, program2), false);
      });
    });
  });
}
