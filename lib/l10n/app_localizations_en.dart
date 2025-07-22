// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sport App';

  @override
  String get loading => 'Loading...';

  @override
  String get errorLoading => 'Loading error';

  @override
  String get noProgram => 'No program';

  @override
  String programName(Object programName) {
    return '$programName';
  }

  @override
  String get sessions => 'Sessions';

  @override
  String get session => 'Session';

  @override
  String get startWorkout => 'Start workout';

  @override
  String get workoutComplete => 'Workout complete 🎉 Congratulations!';

  @override
  String get rest => 'Rest';

  @override
  String seconds(Object seconds) {
    return '$seconds s';
  }

  @override
  String get validate => 'Validate';

  @override
  String get increment => '+';

  @override
  String get decrement => '-';

  @override
  String get exercise => 'Exercise';

  @override
  String get set => 'Set';

  @override
  String get setOf => 'of';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String focus(Object focus) {
    return 'Focus: $focus';
  }

  @override
  String get errorSessionNotFound => 'Session not found';

  @override
  String get errorNoExercises => 'No exercises in this session';

  @override
  String get back => 'Back';

  @override
  String exercisesCount(int count) {
    return '$count exercises';
  }

  @override
  String get startButton => 'START';

  @override
  String get errorDataFormat => 'Data format error';

  @override
  String get errorNotFound => 'Resource not found';

  @override
  String get errorValidation => 'Validation error';

  @override
  String get errorNetwork => 'Connection error';

  @override
  String get errorUnknown => 'Unknown error';

  @override
  String get retry => 'Retry';
}
