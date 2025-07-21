// flutter run -d chrome
// Application Flutter pour suivre un programme d'entraînement
// UI minimaliste et TDA-friendly avec navigation simple

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'ui/program_list_page.dart';
import 'ui/session_list_page.dart';
import 'ui/session_overview_page.dart';
import 'ui/workout_page.dart';
import 'ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Empêcher l'écran de se mettre en veille pendant les séances
  // (ne fonctionne que sur mobile, pas sur web)
  try {
    if (!kIsWeb) {
      await WakelockPlus.enable();
    }
  } catch (e) {
    // Ignorer l'erreur sur les plateformes non supportées
    print('Wakelock non supporté sur cette plateforme: $e');
  }
  
  runApp(SportApp());
}

class SportApp extends StatelessWidget {
  SportApp({super.key});

  // Configuration des routes avec GoRouter
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ProgramListPage(),
      ),
      GoRoute(
        path: '/sessions',
        builder: (context, state) => const SessionListPage(),
      ),
      GoRoute(
        path: '/session/:id',
        builder: (context, state) => SessionOverviewPage(
          sessionId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/workout/:sessionId',
        builder: (context, state) => WorkoutPage(
          sessionId: state.pathParameters['sessionId']!,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sport App',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: buildAppTheme(),
    );
  }
}
