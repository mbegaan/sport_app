import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sport_app/utils/error_handler.dart';
import 'package:sport_app/utils/app_exceptions.dart';
import 'package:sport_app/l10n/app_localizations.dart';

import '../test_helpers/l10n_test_helper.dart';

void main() {
  group('ErrorHandler', () {
    group('handleError', () {
      test('doit convertir une erreur générique en DataLoadingException pour les erreurs d\'assets', () {
        // Given
        final error = Exception('loadString failed');
        
        // When
        final result = ErrorHandler.handleError(error, context: 'test');
        
        // Then
        expect(result, isA<DataLoadingException>());
        expect(result.type, AppErrorType.dataLoading);
        expect(result.details, 'test');
        expect(result.originalError, error);
      });

      test('doit convertir une erreur JSON en DataParsingException', () {
        // Given
        const error = FormatException('Invalid JSON');
        
        // When
        final result = ErrorHandler.handleError(error);
        
        // Then
        expect(result, isA<DataParsingException>());
        expect(result.type, AppErrorType.dataParsing);
      });

      test('doit convertir une StateError firstWhere en NotFoundException', () {
        // Given
        final error = StateError('No element');
        
        // When
        final result = ErrorHandler.handleError(error, context: 'session_search');
        
        // Then
        expect(result, isA<NotFoundException>());
        expect(result.type, AppErrorType.notFound);
        expect(result.details, 'session_search');
      });

      test('doit retourner l\'erreur si c\'est déjà une AppException', () {
        // Given
        const error = ValidationException(
          message: 'Test validation error',
          details: 'test_detail',
        );
        
        // When
        final result = ErrorHandler.handleError(error);
        
        // Then
        expect(result, same(error));
      });

      test('doit créer une AppException générique pour les erreurs inconnues', () {
        // Given
        final error = ArgumentError('Unknown error');
        
        // When
        final result = ErrorHandler.handleError(error, context: 'unknown_context');
        
        // Then
        expect(result, isA<AppException>());
        expect(result.type, AppErrorType.unknown);
        expect(result.details, 'unknown_context');
        expect(result.originalError, error);
      });
    });

    group('getLocalizedMessage', () {
      testWidgets('doit retourner les bons messages localisés', (WidgetTester tester) async {
        // Given
        final l10n = await getTestLocalizations(tester);
        
        // Test dataLoading
        var error = const AppException(type: AppErrorType.dataLoading, message: 'Test');
        var result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorLoading);

        // Test dataParsing
        error = const AppException(type: AppErrorType.dataParsing, message: 'Test');
        result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorDataFormat);

        // Test notFound
        error = const AppException(type: AppErrorType.notFound, message: 'Test');
        result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorNotFound);

        // Test validation
        error = const AppException(type: AppErrorType.validation, message: 'Test');
        result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorValidation);

        // Test network
        error = const AppException(type: AppErrorType.network, message: 'Test');
        result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorNetwork);

        // Test unknown
        error = const AppException(type: AppErrorType.unknown, message: 'Test');
        result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorUnknown);
      });

      testWidgets('doit retourner des messages spécifiques pour les erreurs notFound avec contexte', (WidgetTester tester) async {
        // Given
        final l10n = await getTestLocalizations(tester);
        
        // Test session context
        var error = const NotFoundException(message: 'Test', details: 'session');
        var result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorSessionNotFound);

        // Test exercise context
        error = const NotFoundException(message: 'Test', details: 'exercise');
        result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorNoExercises);

        // Test other context
        error = const NotFoundException(message: 'Test', details: 'autre');
        result = ErrorHandler.getLocalizedMessage(error, l10n);
        expect(result, l10n.errorNotFound);
      });
    });

    group('showErrorSnackBar', () {
      testWidgets('doit afficher une SnackBar avec le message d\'erreur', (WidgetTester tester) async {
        // Given
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('fr'),
              Locale('en'),
            ],
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ErrorHandler.showErrorSnackBar(
                        context,
                        Exception('Test error'),
                        contextInfo: 'test_context',
                      );
                    },
                    child: const Text('Show Error'),
                  );
                },
              ),
            ),
          ),
        );

        // When
        await tester.tap(find.text('Show Error'));
        await tester.pumpAndSettle(); // Ensure animations complete

        // Then
        expect(find.byType(SnackBar), findsOneWidget);
        // Vérifions quel texte est effectivement présent
        final snackBarContent = find.descendant(
          of: find.byType(SnackBar),
          matching: find.byType(Text),
        );
        expect(snackBarContent, findsOneWidget);
      });
    });

    group('buildErrorWidget', () {
      testWidgets('doit créer un widget d\'erreur avec le bon contenu', (WidgetTester tester) async {
        // Given
        final l10n = await getTestLocalizations(tester);
        bool retryCallbackCalled = false;
        
        final widget = MaterialApp(
          home: Scaffold(
            body: ErrorHandler.buildErrorWidget(
              const DataLoadingException(message: 'Test loading error'),
              l10n,
              contextInfo: 'test_context',
              onRetry: () {
                retryCallbackCalled = true;
              },
            ),
          ),
        );

        // When
        await tester.pumpWidget(widget);

        // Then
        expect(find.byIcon(Icons.cloud_off), findsOneWidget);
        expect(find.text(l10n.errorLoading), findsOneWidget);
        expect(find.text(l10n.retry), findsOneWidget);

        // When - tap retry button
        await tester.tap(find.text(l10n.retry));
        await tester.pump();

        // Then
        expect(retryCallbackCalled, isTrue);
      });

      testWidgets('doit afficher les bonnes icônes selon le type d\'erreur', (WidgetTester tester) async {
        // Given
        final l10n = await getTestLocalizations(tester);
        
        // Test DataLoadingException
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorHandler.buildErrorWidget(
                const DataLoadingException(message: 'Test'),
                l10n,
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.cloud_off), findsOneWidget);

        // Test DataParsingException
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorHandler.buildErrorWidget(
                const DataParsingException(message: 'Test'),
                l10n,
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.broken_image), findsOneWidget);

        // Test NotFoundException
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorHandler.buildErrorWidget(
                const NotFoundException(message: 'Test'),
                l10n,
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.search_off), findsOneWidget);

        // Test ValidationException
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorHandler.buildErrorWidget(
                const ValidationException(message: 'Test'),
                l10n,
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.warning), findsOneWidget);

        // Test Network error
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorHandler.buildErrorWidget(
                const AppException(type: AppErrorType.network, message: 'Test'),
                l10n,
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.wifi_off), findsOneWidget);

        // Test Unknown error
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorHandler.buildErrorWidget(
                const AppException(type: AppErrorType.unknown, message: 'Test'),
                l10n,
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });

      testWidgets('ne doit pas afficher le bouton retry si onRetry est null', (WidgetTester tester) async {
        // Given
        final l10n = await getTestLocalizations(tester);
        
        final widget = MaterialApp(
          home: Scaffold(
            body: ErrorHandler.buildErrorWidget(
              Exception('Test error'),
              l10n,
            ),
          ),
        );

        // When
        await tester.pumpWidget(widget);

        // Then
        expect(find.text(l10n.retry), findsNothing);
      });
    });
  });
}
