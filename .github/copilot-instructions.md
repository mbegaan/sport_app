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
- Follows **minimal design principles**: single focus per screen, large touch targets, high contrast colors
- Uses consistent color palette: `Color(0xFF2E3440)` (dark), `Color(0xFFF8F9FA)` (light background), `Color(0xFF6B7280)` (muted)

**State Management (`lib/utils/`)**:
- `TimerNotifier`: Custom ValueNotifier managing workout timers with states: `idle`, `exerciseRunning`, `exerciseCompleted`, `restRunning`, `restCompleted`

## Development Patterns

### UI Design Philosophy
- **TDA-friendly**: Large buttons (min 60px height), clear visual hierarchy, no cognitive overload
- **Physical activity context**: Interface designed for use during exercise (sweat, shaky hands, divided attention)
- **Minimal interactions**: Avoid complex gestures, prefer simple taps and clear state transitions

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
# Launch app (use project script for consistent port)
.\run_web.bat

# Standard Flutter commands
flutter run -d chrome --web-port=8022
flutter build web
flutter test
```

## Key Files to Understand

- `lib/main.dart`: GoRouter setup, wakelock configuration (web-safe)
- `lib/ui/workout_page.dart`: Core workout logic with timer integration
- `lib/utils/timer_notifier.dart`: State machine for exercise/rest timers
- `assets/programme.json`: Data structure with flexible exercise definitions
- `lib/data/program_model.dart`: JSON serialization with error-tolerant parsing

## Common Patterns

**Error-tolerant JSON parsing**: Handle both `int` and `Map` types for exercise parameters
**Web-safe mobile features**: Use `kIsWeb` checks for platform-specific functionality like wakelock
**Consistent spacing**: 24px horizontal padding, 40px between major sections
**Auto-advancing UI**: Minimal user input required during workout flow

When modifying this codebase, prioritize **simplicity**, **accessibility during physical activity**, and **seamless workout flow** over feature complexity.
