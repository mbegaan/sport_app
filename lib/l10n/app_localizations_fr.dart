// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sport App';

  @override
  String get loading => 'Chargement...';

  @override
  String get errorLoading => 'Erreur de chargement';

  @override
  String get noProgram => 'Aucun programme';

  @override
  String programName(Object programName) {
    return '$programName';
  }

  @override
  String get sessions => 'Séances';

  @override
  String get session => 'Séance';

  @override
  String get startWorkout => 'Démarrer la séance';

  @override
  String get workoutComplete => 'Séance terminée 🎉 Félicitations !';

  @override
  String get rest => 'Repos';

  @override
  String seconds(Object seconds) {
    return '$seconds s';
  }

  @override
  String get validate => 'Valider';

  @override
  String get increment => '+';

  @override
  String get decrement => '-';

  @override
  String get exercise => 'Exercice';

  @override
  String get set => 'Série';

  @override
  String get setOf => 'sur';

  @override
  String get next => 'Suivant';

  @override
  String get previous => 'Précédent';

  @override
  String focus(Object focus) {
    return 'Focus : $focus';
  }

  @override
  String get errorSessionNotFound => 'Séance introuvable';

  @override
  String get errorNoExercises => 'Aucun exercice dans cette séance';

  @override
  String get back => 'Retour';

  @override
  String exercisesCount(int count) {
    return '$count exercices';
  }

  @override
  String get startButton => 'COMMENCER';

  @override
  String get errorDataFormat => 'Erreur de format des données';

  @override
  String get errorNotFound => 'Ressource introuvable';

  @override
  String get errorValidation => 'Erreur de validation';

  @override
  String get errorNetwork => 'Erreur de connexion';

  @override
  String get errorUnknown => 'Erreur inconnue';

  @override
  String get retry => 'Réessayer';
}
