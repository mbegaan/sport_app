// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_app/main.dart';

void main() {
  testWidgets('Sport app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SportApp());

    // Wait for any initial async operations to complete
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    // The app should show either the loading indicator or some content
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // The app might show a loading spinner or error message due to missing assets in test
    // This is expected behavior for a smoke test - we just want to ensure no immediate crashes
    expect(tester.takeException(), isNull);
  });
}
