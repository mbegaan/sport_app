import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:sport_app/data/json_loader.dart';
import 'package:sport_app/data/program_model.dart';

// Mock de l'AssetBundle pour les tests
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
    throw Exception('Asset not found: $key');
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

        // Mock du rootBundle pour retourner notre JSON de test
        TestWidgetsFlutterBinding.ensureInitialized();
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('flutter/assets'),
          (MethodCall methodCall) async {
            if (methodCall.method == 'loadString' &&
                methodCall.arguments == 'assets/programme.json') {
              return validJson;
            }
            return null;
          },
        );

        // When: on charge le programme
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
        // Given: Un programme déjà chargé
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

        var callCount = 0;
        TestWidgetsFlutterBinding.ensureInitialized();
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('flutter/assets'),
          (MethodCall methodCall) async {
            callCount++;
            return validJson;
          },
        );

        // When: on charge le programme deux fois
        final program1 = await JsonLoader.loadProgram();
        final program2 = await JsonLoader.loadProgram();

        // Then: le fichier ne doit être lu qu'une seule fois
        expect(callCount, 1);
        expect(program1, same(program2)); // Même instance
        expect(program1.name, 'Cached Program');
      });
    });

    group('Gestion des erreurs', () {
      test('doit lever une exception si le fichier n\'existe pas', () async {
        // Given: Pas de fichier dans les assets
        TestWidgetsFlutterBinding.ensureInitialized();
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('flutter/assets'),
          (MethodCall methodCall) async {
            throw PlatformException(
              code: 'FileNotFound',
              message: 'Unable to load asset',
            );
          },
        );

        // When/Then: le chargement doit lever une exception
        expect(
          () => JsonLoader.loadProgram(),
          throwsA(isA<Exception>()),
        );
      });

      test('doit lever une exception si le JSON est malformé', () async {
        // Given: Un JSON invalide
        const invalidJson = '{ invalid json }';
        
        TestWidgetsFlutterBinding.ensureInitialized();
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('flutter/assets'),
          (MethodCall methodCall) async => invalidJson,
        );

        // When/Then: le chargement doit lever une exception
        expect(
          () => JsonLoader.loadProgram(),
          throwsA(isA<Exception>()),
        );
      });

      test('doit lever une exception si la structure JSON est incorrecte', () async {
        // Given: Un JSON valide mais avec une structure incorrecte
        const incorrectStructureJson = '{"wrong": "structure"}';
        
        TestWidgetsFlutterBinding.ensureInitialized();
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('flutter/assets'),
          (MethodCall methodCall) async => incorrectStructureJson,
        );

        // When/Then: le chargement doit lever une exception
        expect(
          () => JsonLoader.loadProgram(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('Cache management', () {
      test('clearCache doit vider le cache', () async {
        // Given: Un programme en cache
        const validJson = '''
        {
          "program": {
            "name": "First Program",
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

        TestWidgetsFlutterBinding.ensureInitialized();
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('flutter/assets'),
          (MethodCall methodCall) async => validJson,
        );

        final program1 = await JsonLoader.loadProgram();
        expect(program1.name, 'First Program');

        // When: on vide le cache et on change le contenu
        JsonLoader.clearCache();
        
        const newJson = '''
        {
          "program": {
            "name": "Second Program",
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

        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('flutter/assets'),
          (MethodCall methodCall) async => newJson,
        );

        // Then: le nouveau contenu doit être chargé
        final program2 = await JsonLoader.loadProgram();
        expect(program2.name, 'Second Program');
        expect(program1, isNot(same(program2)));
      });
    });
  });
}
