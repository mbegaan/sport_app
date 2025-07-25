# Architecture - Sport App

## Vue d'ensemble

Sport App est une application Flutter minimaliste pour le suivi de programmes d'entraînement. L'architecture privilégie la **simplicité**, la **lisibilité** et la **maintenabilité** à travers des patterns clairs et une séparation stricte des responsabilités.

### Principes directeurs

- **TDA-friendly** : Interface optimisée pour l'usage pendant l'activité physique
- **Design system centralisé** : Cohérence visuelle via des tokens réutilisables
- **Single Responsibility Principle** : Chaque composant a une responsabilité unique
- **Testabilité** : Architecture permettant les tests unitaires et de widgets
- **Déclaratif** : Navigation avec GoRouter, état avec ValueNotifier

## Structure du projet

```
lib/
├── main.dart                    # Point d'entrée avec configuration GoRouter
├── data/                        # Couche de données
│   ├── json_loader.dart        # Singleton pour charger/cacher les assets JSON
│   └── program_model.dart      # Modèles métier (Program, Session, Exercise)
├── ui/                         # Couche présentation
│   ├── theme/                  # Design system centralisé
│   │   ├── app_colors.dart     # Palette de couleurs
│   │   ├── app_text_styles.dart # Styles de texte métier
│   │   ├── app_dimensions.dart  # Tailles et espacements
│   │   ├── app_spacing.dart    # Espacements standardisés
│   │   ├── app_typography.dart # Typographie (poids, famille)
│   │   └── app_theme.dart      # ThemeData Flutter global
│   ├── widgets/                # Composants UI réutilisables
│   │   ├── app_button.dart     # Bouton standardisé (primary/secondary/icon)
│   │   ├── app_scaffold.dart   # Scaffold avec padding standard
│   │   ├── responsive_builder.dart # Helper pour adaptations responsive
│   │   ├── rep_counter.dart    # Affichage du compteur de répétitions
│   │   ├── rep_controls.dart   # Contrôles +/- et validation
│   │   ├── exercise_progress_header.dart # Header de progression
│   │   └── exercise_card.dart  # Carte d'exercice
│   ├── animations/             # Animations isolées
│   │   ├── breathing_animation.dart   # Animation de respiration
│   │   └── effort_animation.dart     # Animation d'effort
│   ├── program_list_page.dart  # Page d'accueil
│   ├── session_list_page.dart  # Liste des séances
│   ├── session_overview_page.dart # Aperçu d'une séance
│   └── workout_page.dart       # Page d'exercice principale
├── utils/                      # Utilitaires métier
│   └── timer_notifier.dart     # Gestion des timers d'exercice/repos
└── styleguide.md              # Guide de style UI
```

## Patterns architecturaux

### 1. Design System Token-Based

**Principe** : Aucune valeur de style n'est codée en dur dans les widgets.

```dart
// ❌ Antipattern
Text('Exercice', style: TextStyle(fontSize: 20, color: Colors.black))

// ✅ Pattern correct
Text('Exercice', style: AppTextStyles.exerciseTitle)
```

**Tokens disponibles** :
- `AppColors` : Palette noir/blanc/gris
- `AppTextStyles` : Styles métier spécialisés
- `AppDimensions` : Tailles de composants et polices
- `AppSpacing` : Espacements standardisés (XS à XL)
- `AppTypography` : Poids et famille de polices

### 2. Single Responsibility Principle (SRP)

**Widget métier** : Chaque widget a une responsabilité unique et claire.

```dart
// RepCounter : Affiche uniquement un nombre
class RepCounter extends StatelessWidget {
  final int count;
  // Responsabilité : affichage du compteur
}

// RepControls : Gère uniquement les interactions +/-/✓
class RepControls extends StatelessWidget {
  final VoidCallback? onIncrement, onDecrement, onValidate;
  // Responsabilité : interactions utilisateur
}
```

### 3. Modèles de données immutables

**Principe** : Les modèles sont immutables avec factory constructors pour JSON.

```dart
class Exercise {
  final String name;
  final int sets;
  final dynamic reps; // flexible : int ou Map<String, int>
  
  const Exercise({required this.name, required this.sets, required this.reps});
  
  factory Exercise.fromJson(Map<String, dynamic> json) {
    // Parsing JSON tolérant aux erreurs
  }
  
  // Propriétés calculées
  bool get isDurationBased => durationSec != null && durationSec! > 0;
}
```

### 4. Navigation déclarative

**GoRouter** avec routes typées et navigation unidirectionnelle :

```dart
GoRoute(path: '/workout/:sessionId', builder: (context, state) => 
  WorkoutPage(sessionId: state.pathParameters['sessionId']!))
```

**Flux de navigation** :
```
ProgramListPage (/) → SessionListPage (/sessions) 
  → SessionOverviewPage (/session/:id) → WorkoutPage (/workout/:id)
```

### 5. Gestion d'état avec ValueNotifier

**TimerNotifier** : État centralisé pour les timers d'exercice.

```dart
enum TimerState { idle, exerciseRunning, exerciseCompleted, restRunning, restCompleted }

class TimerNotifier extends ValueNotifier<TimerData> {
  void startExerciseTimer(int durationSec) { /* */ }
  void startRestTimer(int durationSec) { /* */ }
  double get progress => /* calcul basé sur l'état */ ;
}
```

### 6. Animations isolées

**Principe** : Animations encapsulées dans des widgets dédiés.

```dart
class BreathingAnimation extends StatefulWidget {
  // Animation isolée avec sa propre logique et lifecycle
  // Utilisable dans n'importe quel contexte
}
```

## Conventions de code

### Nommage des fichiers

- **Pages** : `*_page.dart` (ex: `workout_page.dart`)
- **Widgets** : descriptif métier (ex: `rep_counter.dart`)
- **Modèles** : `*_model.dart` (ex: `program_model.dart`)
- **Utilitaires** : fonction principale (ex: `timer_notifier.dart`)
- **Thème** : `app_*.dart` (ex: `app_colors.dart`)

### Structure des widgets

```dart
class MonWidget extends StatelessWidget {
  // 1. Propriétés finales (paramètres)
  final String title;
  final VoidCallback? onTap;
  
  // 2. Constructeur const avec Key
  const MonWidget({super.key, required this.title, this.onTap});
  
  // 3. Build method avec return immédiat
  @override
  Widget build(BuildContext context) {
    return Container(/* utilise uniquement les tokens */);
  }
}
```

### Gestion des erreurs

```dart
// Pattern de gestion d'erreur dans les FutureBuilder
if (snapshot.hasError) {
  return ErrorHandler.buildErrorWidget(
    snapshot.error!,
    l10n,
    contextInfo: 'PageName.loadData',
    onRetry: () {
      // Logique de retry
    },
  );
}
```

**Infrastructure centralisée** :
- **`AppException`** : Exception de base avec type et contexte
- **Types spécialisés** : `DataLoadingException`, `DataParsingException`, `NotFoundException`, `ValidationException`
- **`ErrorHandler`** : Gestionnaire centralisé pour widgets d'erreur et SnackBars
- **Messages localisés** : Intégration complète avec l'i18n

**Usage dans l'interface** :
```dart
// Widget d'erreur avec retry
ErrorHandler.buildErrorWidget(error, l10n, onRetry: () => reload());

// SnackBar d'erreur
ErrorHandler.showErrorSnackBar(context, error, contextInfo: 'action_context');
```

## Points d'extension

### 1. Thématisation

**Ajout de couleurs** : Étendre `AppColors`
```dart
class AppColors {
  static const Color accent = Color(0xFF..); // Nouvelle couleur
}
```

**Nouveaux styles** : Étendre `AppTextStyles`
```dart
static const newStyle = TextStyle(
  fontSize: AppDimensions.newSize,
  fontFamily: AppTypography.fontFamily,
  // ...
);
```

### 2. Internationalisation (i18n)

**Structure actuelle** :
```
lib/l10n/
├── app_fr.arb                          # Traductions françaises (template)
├── app_en.arb                          # Traductions anglaises
├── app_localizations.dart              # Classe générée abstraite
├── app_localizations_fr.dart           # Implémentation française
└── app_localizations_en.dart           # Implémentation anglaise
```

**Configuration** :
- `l10n.yaml` : template-arb-file: app_fr.arb, output-dir: lib/l10n
- `pubspec.yaml` : intl ^0.20.2, flutter_localizations (SDK)

**Usage dans l'interface** :
```dart
final l10n = AppLocalizations.of(context)!;

// Texte simple
Text(l10n.startButton)

// Texte avec paramètres
Text(l10n.exercisesCount(exerciseCount))
```

**Ajout d'une nouvelle langue** :
1. Créer `app_xx.arb` avec toutes les clés du template français
2. Exécuter `flutter gen-l10n` pour générer les classes
3. Ajouter la locale dans `supportedLocales` de MaterialApp

**Traductions paramétrées** :
```json
"exercisesCount": "{count, plural, =0{Aucun exercice} =1{{count} exercice} other{{count} exercices}}",
"@exercisesCount": {
  "placeholders": {
    "count": {"type": "int"}
  }
}
```

### 3. Responsive Design

**Infrastructure complète implémentée** avec breakpoints et composants adaptatifs.

**Breakpoints définis** :
```dart
class AppDimensions {
  // Breakpoints responsive
  static const double smallScreenWidth = 600.0;   // Mobile
  static const double mediumScreenWidth = 900.0;  // Tablet
  static const double largeScreenWidth = 1200.0;  // Desktop
  
  // Méthodes de détection
  static bool isSmallScreen(double width) => width < smallScreenWidth;
  static bool isMediumScreen(double width) => width >= smallScreenWidth && width < largeScreenWidth;
  static bool isLargeScreen(double width) => width >= largeScreenWidth;
  
  // Adaptations automatiques
  static double paddingResponsive(double screenWidth) {
    if (isSmallScreen(screenWidth)) return mainPadding;           // 24px
    if (isMediumScreen(screenWidth)) return mainPadding * 1.5;    // 36px
    return mainPadding * 2;                                       // 48px
  }
  
  static double buttonHeightResponsive(double screenWidth) {
    return isSmallScreen(screenWidth) ? buttonHeight : 48.0;      // 60px -> 48px
  }
}
```

**Helper widgets responsifs** :
```dart
// ResponsiveBuilder : Widget wrapper pour adaptations screen-width
ResponsiveBuilder(
  builder: (context, screenWidth) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingResponsive(screenWidth)),
      child: child,
    );
  },
)

// ResponsiveContext : Extension pour accès direct
context.isSmallScreen     // bool
context.paddingResponsive // double adaptée
context.buttonHeight      // double adaptée
```

**Composants adaptatifs** :
- **AppButton** : Hauteur responsive (60px mobile, 48px tablet/desktop)
- **AppScaffold** : Padding adaptatif selon la taille d'écran  
- **RepCounter** : Taille de police responsive (60px/80px/100px)
- **Toutes les pages** : Spacing et padding adaptatifs

**Pattern d'usage** :
```dart
class MonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenWidth) {
        return Padding(
          padding: EdgeInsets.all(AppDimensions.paddingResponsive(screenWidth)),
          child: Text(
            'Titre',
            style: AppTextStyles.exerciseTitleResponsive(context, screenWidth),
          ),
        );
      },
    );
  }
}
```

### 4. Nouveaux types d'exercices

**Extension du modèle Exercise** :
```dart
class Exercise {
  final ExerciseType type; // duration, reps, time_based, etc.
  // Nouvelles propriétés selon le type
}
```

### 5. Persistance locale

**Structure prévue** :
```
lib/data/
├── json_loader.dart       # Assets (existant)
├── local_storage.dart     # SharedPreferences/SQLite
└── data_repository.dart   # Abstraction données
```

## Tests et qualité

### Structure des tests

```
test/
├── unit/                  # Tests unitaires (modèles, utilitaires)
├── widget/                # Tests de widgets (UI isolée)
└── integration/           # Tests d'intégration (à venir)
```

### Couverture attendue

- **Widgets UI** : 100% (interactions, styles, cas limites)
- **Modèles** : 100% (parsing JSON, propriétés calculées)
- **Utilitaires** : 100% (TimerNotifier, JsonLoader)
- **Pages** : Tests d'intégration (navigation, état global)

### Patterns de test

```dart
group('Widget Tests', () {
  testWidgets('should display correctly', (tester) async {
    // Given
    await tester.pumpWidget(MaterialApp(home: MonWidget()));
    
    // When/Then
    expect(find.text('Expected'), findsOneWidget);
  });
});
```

## Performance et optimisation

### Bonnes pratiques

1. **Widgets const** : Tous les widgets statiques sont `const`
2. **Clés de widget** : Keys utilisées pour les listes dynamiques
3. **Animations isolées** : AnimationController local aux widgets
4. **Caching** : JsonLoader avec singleton pattern
5. **Lazy loading** : FutureBuilder pour le chargement asynchrone

### Points de vigilance

- **Memory leaks** : Dispose des TimerNotifier et AnimationController
- **Rebuilds** : ValueNotifier pour limiter les reconstructions
- **Asset size** : Optimisation des images et JSON

## Migration et évolution

### Ajout d'une nouvelle fonctionnalité

1. **Conception** : Identifier les nouveaux tokens/widgets nécessaires
2. **Implémentation** : Suivre les patterns existants (SRP, tokens)
3. **Tests** : Couverture complète (unit + widget)
4. **Documentation** : Mise à jour architecture.md et styleguide.md

### Mise à jour du design system

1. **Tokens** : Ajouter dans app_*.dart approprié
2. **Validation** : Tests pour vérifier la cohérence
3. **Migration** : Mettre à jour les widgets existants
4. **Documentation** : Mise à jour styleguide.md

---

*Cette architecture favorise l'évolutivité tout en maintenant la simplicité requise pour une app de fitness TDA-friendly.*
