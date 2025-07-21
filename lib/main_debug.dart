import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'ui/program_list_page.dart';

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
  
  runApp(SportAppDebug());
}

class SportAppDebug extends StatelessWidget {
  SportAppDebug({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport App Debug',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 14),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sport App - Test'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fitness_center, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Sport App Fonctionne !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgramListPage(),
                    ),
                  );
                },
                child: Text('Aller aux Programmes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
