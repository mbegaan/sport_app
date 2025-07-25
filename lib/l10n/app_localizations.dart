import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Sport App'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement...'**
  String get loading;

  /// No description provided for @errorLoading.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de chargement'**
  String get errorLoading;

  /// No description provided for @noProgram.
  ///
  /// In fr, this message translates to:
  /// **'Aucun programme'**
  String get noProgram;

  /// No description provided for @programName.
  ///
  /// In fr, this message translates to:
  /// **'{programName}'**
  String programName(Object programName);

  /// No description provided for @sessions.
  ///
  /// In fr, this message translates to:
  /// **'Séances'**
  String get sessions;

  /// No description provided for @session.
  ///
  /// In fr, this message translates to:
  /// **'Séance'**
  String get session;

  /// No description provided for @startWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer la séance'**
  String get startWorkout;

  /// No description provided for @workoutComplete.
  ///
  /// In fr, this message translates to:
  /// **'Séance terminée 🎉 Félicitations !'**
  String get workoutComplete;

  /// No description provided for @rest.
  ///
  /// In fr, this message translates to:
  /// **'Repos'**
  String get rest;

  /// No description provided for @seconds.
  ///
  /// In fr, this message translates to:
  /// **'{seconds} s'**
  String seconds(Object seconds);

  /// No description provided for @validate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get validate;

  /// No description provided for @increment.
  ///
  /// In fr, this message translates to:
  /// **'+'**
  String get increment;

  /// No description provided for @decrement.
  ///
  /// In fr, this message translates to:
  /// **'-'**
  String get decrement;

  /// No description provided for @exercise.
  ///
  /// In fr, this message translates to:
  /// **'Exercice'**
  String get exercise;

  /// No description provided for @set.
  ///
  /// In fr, this message translates to:
  /// **'Série'**
  String get set;

  /// No description provided for @setOf.
  ///
  /// In fr, this message translates to:
  /// **'sur'**
  String get setOf;

  /// No description provided for @next.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In fr, this message translates to:
  /// **'Précédent'**
  String get previous;

  /// No description provided for @focus.
  ///
  /// In fr, this message translates to:
  /// **'Focus : {focus}'**
  String focus(Object focus);

  /// No description provided for @errorSessionNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Séance introuvable'**
  String get errorSessionNotFound;

  /// No description provided for @errorNoExercises.
  ///
  /// In fr, this message translates to:
  /// **'Aucun exercice dans cette séance'**
  String get errorNoExercises;

  /// No description provided for @back.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get back;

  /// No description provided for @exercisesCount.
  ///
  /// In fr, this message translates to:
  /// **'{count} exercices'**
  String exercisesCount(int count);

  /// No description provided for @startButton.
  ///
  /// In fr, this message translates to:
  /// **'COMMENCER'**
  String get startButton;

  /// No description provided for @errorDataFormat.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de format des données'**
  String get errorDataFormat;

  /// No description provided for @errorNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Ressource introuvable'**
  String get errorNotFound;

  /// No description provided for @errorValidation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de validation'**
  String get errorValidation;

  /// No description provided for @errorNetwork.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de connexion'**
  String get errorNetwork;

  /// No description provided for @errorUnknown.
  ///
  /// In fr, this message translates to:
  /// **'Erreur inconnue'**
  String get errorUnknown;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
