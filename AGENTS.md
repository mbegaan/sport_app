# AGENTS.md

## Purpose
- Flutter fitness app with minimal, TDA-friendly UX: prioritize fast, low-friction workout flow over feature complexity.
- Navigation is intentionally linear: `/` -> `/sessions` -> `/session/:id` -> `/workout/:sessionId` (`lib/main.dart`).

## Architecture That Matters
- UI layer in `lib/ui/` is thin and stateful pages orchestrate flow; reusable components live in `lib/ui/widgets/` and `lib/ui/animations/`.
- Data now goes through `DataService` (`lib/data/services/data_service.dart`), not directly through `JsonLoader` for app screens.
- Storage boundary is Isar (`lib/data/services/isar_service.dart`) with startup migration from JSON assets (`lib/data/services/migration_service.dart`).
- Compatibility DTOs (`ProgramData`, `SessionData`, `ExerciseData`) adapt Isar models to existing UI contracts.
- Timer state is isolated in `TimerNotifier` (`lib/utils/timer_notifier.dart`) and consumed via `ValueListenableBuilder` in `lib/ui/workout_page.dart`.

## Data + Control Flow
- App startup (`main`) does: `WakelockPlus.enable()` -> `DataService.initialize()` -> run app.
- First launch path: `DataService.initialize()` detects empty DB, then migrates `assets/muscles.json`, `assets/exercises.json`, `assets/programme.json` (+ optional `assets/programmes/chaine_porteuse.json`).
- Workout progression logic is page-driven in `WorkoutPage`: set completion -> rest timer -> next set/exercise -> completion redirect.
- `SessionData.id` is string-based in routing; migration normalizes numeric and string IDs.

## Non-Obvious Conventions (Project-Specific)
- Strict design tokens only: avoid `Colors.*`, inline `TextStyle`, and hardcoded spacing; use `AppColors`, `AppTextStyles`, `AppSpacing`, `AppDimensions`.
- Responsive behavior is expected even for simple pages; use `ResponsiveBuilder` or `BuildContext` responsive extension.
- Error UX is centralized: convert/translate errors with `ErrorHandler` + `AppException` types, including retry widgets/snackbars.
- Keep animation logic encapsulated in dedicated widgets (`BreathingAnimation`, `EffortAnimation`), not mixed into page state.
- Maintain SRP-style widgets (e.g., `RepCounter` display-only, `RepControls` interaction-only).

## Dev Workflows
- Install/run/test basics:
  - `flutter pub get`
  - `flutter run`
  - `flutter test`
- Android quick run script: `./run.bat` (invokes `flutter run -d android`).
- Useful checks while editing:
  - `flutter analyze`
  - `flutter test test/unit`
  - `flutter test test/widget`
- If Isar schema models change in `lib/data/models/`, regenerate generated files with build runner before testing.

## Testing Signals in This Repo
- Unit tests focus on parsing/timer/error behavior (`test/unit/`), including `JsonLoader` cache/error paths.
- Widget tests validate design-system widgets and animations (`test/widget/`, `test/theme/`).
- `test/mock_bundle.dart` shows expected pattern for asset-driven tests.

## AI Guidance Sources Reviewed
- `.github/copilot-instructions.md` (primary AI coding conventions)
- `CLAUDE.md` (stack + baseline commands)
- `README.md` (generic Flutter scaffold; lower priority than repo-specific docs/code)

