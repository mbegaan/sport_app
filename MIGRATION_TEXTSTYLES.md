# Migration vers TextTheme Flutter

## Résumé des changements

Les styles de texte ont été migrés pour utiliser le `TextTheme` de Flutter plutôt que des valeurs fixes en pixels. Cela permet :

- **Accessibilité** : Respect des préférences de taille de police de l'utilisateur
- **Responsive** : Adaptation automatique selon la densité d'écran
- **Cohérence** : Utilisation des standards Material Design
- **Maintenance** : Styles centralisés et basés sur des tokens sémantiques

## Nouvelle API

### Styles avec Context (recommandé)

```dart
// Nouveau - Utilise le TextTheme de Flutter
Text(
  'Nom exercice',
  style: AppTextStyles.exerciseTitleContext(context),
)

Text(
  '1/5',
  style: AppTextStyles.exerciseFractionContext(context),
)

AppButton(
  style: AppTextStyles.buttonContext(context),
)
```

### Styles responsifs

```dart
// Responsive automatique basé sur la taille d'écran
ResponsiveBuilder(
  builder: (context, screenWidth) {
    return Text(
      'Titre adaptatif',
      style: AppTextStyles.exerciseTitleResponsive(context, screenWidth),
    );
  },
)
```

### Compatibilité arrière (temporaire)

```dart
// Ancien - Toujours fonctionnel pour migration progressive
Text(
  'Nom exercice',
  style: AppTextStyles.exerciseTitle, // ← Getter statique
)
```

## Mapping des tailles

| Style | Ancien (px) | Nouveau (TextTheme) | Responsive |
|-------|-------------|---------------------|------------|
| `exerciseTitle` | 12px fixe | `titleSmall` (14dp) | 14→19→23dp |
| `exerciseFraction` | 12px fixe | `labelMedium` (12dp) | 12→16→20dp |
| `button` | 18px fixe | `labelLarge` (14dp) | 14→16→19dp |
| `repCounter` | 60px fixe | `displayLarge` (57dp) | 57→76→95dp |

## Avantages du TextTheme

### 1. Accessibilité
```dart
// L'utilisateur peut ajuster la taille dans les paramètres système
// Les styles s'adaptent automatiquement
```

### 2. Densité d'écran
```dart
// Adaptation automatique aux écrans haute densité
// Plus besoin de calculer manuellement les tailles
```

### 3. Cohérence Material
```dart
// Utilise les standards de Google Material Design
// Hiérarchie typographique respectée
```

### 4. Responsive natif
```dart
// Les tailles s'adaptent selon le facteur d'échelle du système
// Meilleure expérience multi-plateforme
```

## Migration progressive

1. **Phase 1** : Nouveau code utilise les méthodes avec `Context`
2. **Phase 2** : Migration des widgets existants au fur et à mesure
3. **Phase 3** : Suppression des getters de compatibilité

## Exemples d'usage

### Widget d'exercice
```dart
class ExerciseProgressHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Fraction d'exercice - responsive automatique
        Container(
          child: Text(
            '${currentExerciseIndex + 1}/$totalExercises',
            style: AppTextStyles.exerciseFractionContext(context),
          ),
        ),
        // Nom d'exercice - s'adapte aux préférences utilisateur
        Text(
          exerciseName,
          style: AppTextStyles.exerciseTitleContext(context),
        ),
      ],
    );
  }
}
```

### Utilisation responsive
```dart
class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenWidth) {
        return Text(
          'Nom exercice',
          style: AppTextStyles.exerciseTitleResponsive(context, screenWidth),
        );
      },
    );
  }
}
```

Cette migration respecte les bonnes pratiques Flutter et améliore l'accessibilité de l'application.
