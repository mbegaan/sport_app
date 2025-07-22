import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sport_app/l10n/app_localizations.dart';

/// Helper pour obtenir les localisations dans les tests
Future<AppLocalizations> getTestLocalizations(WidgetTester tester) async {
  late AppLocalizations l10n;
  
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
      home: Builder(
        builder: (context) {
          l10n = AppLocalizations.of(context)!;
          return Container();
        },
      ),
    ),
  );
  
  return l10n;
}
