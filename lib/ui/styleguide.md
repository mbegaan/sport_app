# Styleguide UI – Sport App

## Palette

### Couleurs principales
- Noir : #000000 (`AppColors.black`)
- Blanc : #FFFFFF (`AppColors.white`)
- Gris : #6B7280 (`AppColors.grey`)

### Couleurs sémantiques
- Succès : #10B981 (`AppColors.success`)
- Attention : #F59E0B (`AppColors.warning`)
- Erreur : #EF4444 (`AppColors.error`)
- Information : #3B82F6 (`AppColors.info`)

### Couleurs surface
- Gris clair : #F3F4F6 (`AppColors.greyLight`)
- Gris foncé : #374151 (`AppColors.greyDark`)

### Variantes d'état (nouvelles - Priorité 6)
- Hover : #1F1F1F (`AppColors.primaryHover`)
- Pressed : #0A0A0A (`AppColors.primaryPressed`)
- Disabled : #9CA3AF (`AppColors.primaryDisabled`)
- Surface élevée : #FAFAFA (`AppColors.surfaceElevated`)
- Surface enfoncée : #E5E7EB (`AppColors.surfacePressed`)

### Couleurs overlay
- Overlay léger : rgba(0,0,0,0.06) (`AppColors.overlayLight`)
- Overlay moyen : rgba(0,0,0,0.10) (`AppColors.overlayMedium`)
- Overlay foncé : rgba(0,0,0,0.20) (`AppColors.overlayDark`)

### Couleurs spécialisées
- Timer actif : success (`AppColors.timerActive`)
- Timer en pause : warning (`AppColors.timerPaused`)
- Timer terminé : black (`AppColors.timerCompleted`)
- Progress actif : black (`AppColors.progressActive`)
- Progress inactif : grey (`AppColors.progressInactive`)

## Typographie

### Police
- Famille : Inter (unique)
- Poids : Light (300), Regular (400), Medium (500), Bold (700)

### Hiérarchie des tailles
- Page title : 28px (`AppTextStyles.pageTitle`)
- Section header : 16px (`AppTextStyles.sectionHeader`)
- Exercise title : 12px (`AppTextStyles.exerciseTitle`)
- Button text : 18px (`AppTextStyles.button`)
- Rep counter : 60px (`AppTextStyles.repCounter`)
- Body text : 16px (`AppTextStyles.inputText`)
- Caption : 12px (`AppTextStyles.caption`)
- Metadata : 11px (`AppTextStyles.metadata`)

### Styles étendus
- Messages d'état : Success, Warning, Error, Info
- Formulaires : Label, Input, Placeholder
- Navigation : NavigationItem

### Variantes de boutons (nouvelles - Priorité 6)
- Bouton primaire : 18px medium blanc (`AppTextStyles.buttonPrimary`)
- Bouton secondaire : 18px medium noir (`AppTextStyles.buttonSecondary`)
- Bouton petit : 14px medium blanc (`AppTextStyles.buttonSmall`)
- Bouton grand : 22px medium blanc (`AppTextStyles.buttonLarge`)
- Bouton désactivé : 18px medium gris (`AppTextStyles.buttonDisabled`)

### Styles d'état (nouveaux)
- Texte hover : 16px medium hover (`AppTextStyles.textHover`)
- Texte pressed : 16px medium pressed (`AppTextStyles.textPressed`)
- Texte sélectionné : 16px bold noir (`AppTextStyles.textSelected`)

## Spacing

### Espacements de base
- XS : 4px (`AppSpacing.gapXS`)
- S : 8px (`AppSpacing.gapS`)
- M : 16px (`AppSpacing.gapM`)
- L : 24px (`AppSpacing.gapL`)
- XL : 40px (`AppSpacing.gapXL`)
- XXL : 64px (`AppSpacing.gapXXL`)
- XXXL : 96px (`AppSpacing.gapXXXL`)

### Espacements sémantiques
- Section : 40px (`AppSpacing.sectionGap`)
- Items : 16px (`AppSpacing.itemGap`)
- Inline : 8px (`AppSpacing.inlineGap`)
- Margin : 24px (`AppSpacing.marginGap`)

### Dimensions principales
- Padding principal : 24px (`AppDimensions.mainPadding`)
- Hauteur bouton : 60px (`AppDimensions.buttonHeight`)
- Radius bouton : 16px (`AppDimensions.buttonRadius`)

### Helpers EdgeInsets (nouveaux - Priorité 6)
- Padding uniforme : `AppSpacing.allS()`, `AppSpacing.allM()`, `AppSpacing.allL()`
- Padding horizontal : `AppSpacing.horizontalS()`, `AppSpacing.horizontalM()`, `AppSpacing.horizontalL()`
- Padding vertical : `AppSpacing.verticalS()`, `AppSpacing.verticalM()`, `AppSpacing.verticalL()`
- Padding directionnel : `AppSpacing.bottomS()`, `AppSpacing.bottomL()`
- Combinaisons courantes : `AppSpacing.listItem()`, `AppSpacing.formField()`, `AppSpacing.card()`

## Animations

### Durées
- Fade court : 200ms (`AppAnimations.fadeShort`)
- Fade moyen : 400ms (`AppAnimations.fadeMedium`)
- Slide court : 250ms (`AppAnimations.slideShort`)
- Slide moyen : 500ms (`AppAnimations.slideMedium`)

### Durées spécialisées
- Cycle respiration : 4s (`AppAnimations.breathingCycle`)
- Animation effort : 800ms (`AppAnimations.effortAnimation`)
- Transition page : 300ms (`AppAnimations.pageTransition`)

### Courbes
- Standard : `Curves.easeInOut` (`AppAnimations.ease`)
- Douce : `Curves.easeInOutSine` (`AppAnimations.gentle`)
- Respiration : `Curves.easeInOutSine` (`AppAnimations.breathingCurve`)

## Ombres et élévations

### Niveaux d'ombres
- Aucune : Transparent (`AppShadows.none`)
- Subtile : Noir 3% (`AppShadows.subtle`)
- Douce : Noir 6% (`AppShadows.soft`)
- Moyenne : Noir 8% (`AppShadows.medium`)
- Flottante : Noir 12% (`AppShadows.floating`)

### Usage
- Cartes : `AppShadows.cardShadow`
- Boutons : `AppShadows.buttonShadow` (aucune)
- Modales : `AppShadows.modalShadow`

## Responsive

### Breakpoints
- Mobile : < 600px (`AppDimensions.smallScreenWidth`)
- Tablet : 600px - 1200px (`AppDimensions.mediumScreenWidth`)
- Desktop : > 1200px (`AppDimensions.largeScreenWidth`)

### Adaptations
- Padding : 24px → 36px → 48px
- Boutons : 60px → 48px
- Rep counter : 60px → 80px → 100px

## Règles de conformité

### Interdictions strictes
- ❌ Aucune couleur en dur (`Colors.black` → `AppColors.black`)
- ❌ Aucun `TextStyle` inline → tout via `AppTextStyles`
- ❌ Aucun `EdgeInsets` en dur → tout via `AppDimensions`/`AppSpacing`
- ❌ Aucune valeur magique (tailles, durées) → tokens centralisés

### Bonnes pratiques
- ✅ Utiliser `DesignSystemValidator` en mode debug
- ✅ Respecter la hiérarchie typographique
- ✅ Maintenir un contraste WCAG AA (4.5:1 minimum)
- ✅ Utiliser les espacements sémantiques appropriés

### Validation automatique
```dart
// En mode debug, valider la conformité
myWidget.validateDesignSystem()

// Vérifier une couleur
DesignSystemValidator.isValidColor(color)

// Trouver l'espacement le plus proche
DesignSystemValidator.getNearestValidSpacing(20.0) // → 24.0
```

## Composants étendus (Priorité 6)

### AppCard
Carte standardisée avec variantes et élévation :
```dart
AppCard(
  variant: AppCardVariant.standard, // compact, standard, spacious
  elevated: true,
  onTap: () => action(),
  child: content,
)
```

### AppChip
Chip avec états visuels :
```dart
AppChip(
  label: 'Active',
  state: AppChipState.active, // normal, selected, disabled, active, warning, error
  onTap: () => toggle(),
)
```

### Usage des nouveaux helpers
```dart
// Remplace EdgeInsets.all(16.0)
Container(padding: AppSpacing.allM())

// Remplace EdgeInsets.only(bottom: 24.0)
Container(padding: AppSpacing.bottomL())

// Remplace EdgeInsets.symmetric(horizontal: 24.0)
Container(padding: AppSpacing.horizontalL())
```

## Extension du système

### Ajouter une nouvelle couleur
1. Ajouter dans `AppColors`
2. Mettre à jour `DesignSystemValidator.isValidColor()`
3. Documenter dans ce styleguide
4. Tester le contraste

### Ajouter un nouveau style de texte
1. Créer dans `AppTextStyles`
2. Respecter la hiérarchie existante
3. Utiliser les tokens typographiques
4. Documenter l'usage prévu

### Ajouter un nouvel espacement
1. Évaluer si un token existant convient
2. Si nécessaire, ajouter dans `AppSpacing`
3. Suivre la progression géométrique (4, 8, 16, 24, 40...)
4. Créer un alias sémantique si besoin

---

*Ce styleguide évolue avec l'application. Toute modification doit être documentée et validée.*
