# Tests Responsive - Sport App

## Objectif

Validation du comportement responsive de l'application sur différentes tailles d'écran selon les breakpoints définis :
- **Mobile** : < 600px
- **Tablet** : 600px - 1200px  
- **Desktop** : > 1200px

## Checklist de tests

### 1. Breakpoints et adaptations

#### Mobile (< 600px)
- [ ] Padding des pages : 24px
- [ ] Hauteur des boutons : 60px
- [ ] Taille du compteur de répétitions : 60px
- [ ] Taille des boutons : taille normale (14px)

#### Tablet (600px - 1200px)
- [ ] Padding des pages : 36px (1.5x)
- [ ] Hauteur des boutons : 48px
- [ ] Taille du compteur de répétitions : 80px
- [ ] Taille des boutons : réduite (16px)

#### Desktop (> 1200px)
- [ ] Padding des pages : 48px (2x)
- [ ] Hauteur des boutons : 48px
- [ ] Taille du compteur de répétitions : 100px
- [ ] Taille des boutons : réduite (16px)

### 2. Composants à tester

#### Pages principales
- [ ] `ProgramListPage` - Adaptation des paddings et espacements
- [ ] `SessionListPage` - ListView avec padding responsive
- [ ] `SessionOverviewPage` - Spacing adaptatif
- [ ] `WorkoutPage` - Padding et spacing complets

#### Widgets spécialisés
- [ ] `AppButton` - Hauteur adaptive selon breakpoint
- [ ] `AppScaffold` - Padding latéral adaptatif
- [ ] `RepCounter` - Taille de police progressive
- [ ] `ResponsiveBuilder` - Fonctionnement correct du builder pattern

### 3. Tests manuels

#### Chrome DevTools
1. Ouvrir l'application : http://localhost:8022
2. Ouvrir DevTools (F12)
3. Activer le mode responsive (Ctrl+Shift+M)
4. Tester les résolutions suivantes :

**Mobile**
- iPhone SE (375px) ✓ Breakpoint mobile
- iPhone 12 Pro (390px) ✓ Breakpoint mobile

**Tablet**
- iPad (768px) ✓ Breakpoint tablet
- iPad Pro (1024px) ✓ Breakpoint tablet

**Desktop**
- Desktop (1280px) ✓ Breakpoint desktop
- Large Desktop (1920px) ✓ Breakpoint desktop

#### Points d'attention
- [ ] Transitions fluides entre breakpoints
- [ ] Pas de déformation des composants
- [ ] Lisibilité maintenue sur tous les écrans
- [ ] Touch targets respectés (44px minimum)
- [ ] Pas de débordement horizontal

### 4. Validation automatique

#### Méthodes de test
```dart
testWidgets('should adapt padding for mobile', (tester) async {
  await tester.binding.setSurfaceSize(Size(400, 800)); // Mobile
  // Test padding = 24px
});

testWidgets('should adapt padding for tablet', (tester) async {
  await tester.binding.setSurfaceSize(Size(800, 1024)); // Tablet
  // Test padding = 36px
});

testWidgets('should adapt padding for desktop', (tester) async {
  await tester.binding.setSurfaceSize(Size(1400, 1024)); // Desktop
  // Test padding = 48px
});
```

## Résultats attendus

### Performance
- Pas de rebuilds excessifs lors du resize
- Transitions fluides entre breakpoints
- Maintien de la performance sur mobile

### UX/UI
- Interface reste utilisable sur tous les formats
- Hiérarchie visuelle préservée
- Espacement cohérent et proportionnel
- Touch targets accessibles

### Conformité TDA
- Boutons restent facilement cliquables
- Texte reste lisible même en mouvement
- Interface ne surcharge pas cognitivement

## Exécution des tests

```bash
# Tests automatisés
flutter test test/responsive/

# Lancement pour tests manuels
.\run_web.bat

# Ouvrir dans Chrome avec DevTools pour tests responsive
```

---

*Tests à effectuer après chaque modification des breakpoints ou adaptations responsive.*
