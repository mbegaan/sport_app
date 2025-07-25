# Flutter Sport App - Copilot Instructions

## Architecture Overview

This is a **Flutter fitness tracking app** with a **minimal, TDA-friendly UI** for following workout routines from a local JSON file. The app uses **declarative navigation** with GoRouter and **ValueNotifier** for state management.

### Core Navigation Flow
- `ProgramListPage` (`/`) → `SessionListPage` (`/sessions`) → `SessionOverviewPage` (`/session/:id`) → `WorkoutPage` (`/workout/:id`)
- **One-way navigation**: Users flow through the workout sequence without complex back-navigation patterns
- All routes defined in `lib/main.dart` using GoRouter v7.1.1

### Key Components

**Data Layer (`lib/data/`)**:
- `JsonLoader`: Singleton pattern with caching for loading `assets/programme.json`
- `Program/Session/Exercise` models with JSON serialization that handles flexible data types (e.g., `reps` can be `int` or `Map` with min/max)

**UI Layer (`lib/ui/`)**:
- **Strict design system**: All styles via tokens (`AppColors`, `AppTextStyles`, `AppDimensions`) - NO hardcoded values
- **Token-based architecture**: `AppColors.black` instead of `Colors.black`, `AppTextStyles.pageTitle` instead of inline `TextStyle`
- **Modular structure**: `theme/`, `widgets/`, `animations/` with clear separation
- **Responsive system**: `ResponsiveBuilder` widget handles screen size adaptations

**State Management (`lib/utils/`)**:
- `TimerNotifier`: Custom ValueNotifier managing workout timers with states: `idle`, `exerciseRunning`, `exerciseCompleted`, `restRunning`, `restCompleted`

## Development Patterns

### Design System (STRICT Rules)
- **NO hardcoded styles**: Use `AppColors.black` not `Colors.black`, `AppTextStyles.pageTitle` not inline `TextStyle`
- **Token hierarchy**: Colors (`AppColors`) → Typography (`AppTypography`) → Text Styles (`AppTextStyles`) → Components
- **Monochrome palette**: Strict black/white/grey system with semantic colors for future features
- **Responsive dimensions**: Use `AppDimensions.buttonHeightResponsive(screenWidth)` for adaptive sizing

### UI Design Philosophy
- **TDA-friendly**: Large buttons (min 60px height), clear visual hierarchy, no cognitive overload
- **Physical activity context**: Interface designed for use during exercise (sweat, shaky hands, divided attention)
- **Minimal interactions**: Avoid complex gestures, prefer simple taps and clear state transitions

### Animation System
- **Modular animations**: `BreathingAnimation` (rest periods), `EffortAnimation` (duration-based exercises)
- **Performance-optimized**: Use `SingleTickerProviderStateMixin` for isolated animations
- **Organic motion**: `Curves.easeInOutCubic` for smooth, natural feel

### Component Architecture
- **Single Responsibility**: Each widget has one clear purpose (`RepCounter` displays numbers, `RepControls` handles +/-)
- **Composition over inheritance**: Build complex UIs from simple, focused widgets
- **Error-tolerant parsing**: Handle flexible JSON data types in `Exercise` model

### Exercise Types
- **Rep-based exercises**: User manually tracks completed reps with +/- controls
- **Duration-based exercises**: Automatic timer with circular progress indicator
- Both types use the `Exercise.isDurationBased` computed property for conditional rendering

### Timer Implementation
```dart
// Exercise timer (auto-advances on completion)
_timerNotifier.startExerciseTimer(durationSec);

// Rest timer (auto-advances after completion + 1s delay)
_timerNotifier.startRestTimer(restDurationSec);
```

### State Flow in WorkoutPage
1. Load session data via `JsonLoader.loadProgram()`
2. Track: `_currentExerciseIndex`, `_currentSet`, `_completedReps`
3. Auto-advance through sets → rest → next exercise → completion
4. Handle both manual rep counting and automatic duration timers

## Development Commands

```bash
# Launch app (Android - primary target)
.\run.bat

# Web development (using VS Code task)
flutter run -d chrome --web-port=8080

# Standard Flutter commands
flutter build web
flutter test
```

## Key Files to Understand

- `lib/main.dart`: GoRouter setup, wakelock configuration (web-safe)
- `lib/ui/workout_page.dart`: Core workout logic with timer integration
- `lib/utils/timer_notifier.dart`: State machine for exercise/rest timers
- `assets/programme.json`: Data structure with flexible exercise definitions
- `lib/data/program_model.dart`: JSON serialization with error-tolerant parsing
- `lib/ui/theme/`: Complete design system tokens (colors, typography, dimensions)
- `lib/ui/styleguide.md`: Visual reference for all UI patterns and components

## Critical Patterns

**Design System Migration**: The app has undergone complete design system migration - all UI follows strict token-based architecture
**Error-tolerant JSON parsing**: Handle both `int` and `Map` types for exercise parameters
**Web-safe mobile features**: Use `kIsWeb` checks for platform-specific functionality like wakelock
**Animation isolation**: Use dedicated animation widgets (`BreathingAnimation`, `EffortAnimation`) for workout states
**Responsive consistency**: All dimensions use `ResponsiveBuilder` and `AppDimensions` responsive methods

When modifying this codebase, prioritize **design system compliance**, **accessibility during physical activity**, and **seamless workout flow** over feature complexity.
