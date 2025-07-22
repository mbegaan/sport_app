/// Types d'erreurs spécifiques à l'application
enum AppErrorType {
  /// Erreur de chargement des données (JSON, assets)
  dataLoading,
  
  /// Erreur de parsing/format des données
  dataParsing,
  
  /// Ressource introuvable (session, exercice)
  notFound,
  
  /// Erreur de validation des données
  validation,
  
  /// Erreur réseau/connectivité
  network,
  
  /// Erreur inconnue/générique
  unknown,
}

/// Exception personnalisée pour l'application
class AppException implements Exception {
  final AppErrorType type;
  final String message;
  final String? details;
  final Object? originalError;

  const AppException({
    required this.type,
    required this.message,
    this.details,
    this.originalError,
  });

  @override
  String toString() {
    return 'AppException(type: $type, message: $message, details: $details)';
  }
}

/// Erreurs spécifiques pour le chargement de données
class DataLoadingException extends AppException {
  const DataLoadingException({
    required String message,
    String? details,
    Object? originalError,
  }) : super(
          type: AppErrorType.dataLoading,
          message: message,
          details: details,
          originalError: originalError,
        );
}

/// Erreurs spécifiques pour le parsing de données
class DataParsingException extends AppException {
  const DataParsingException({
    required String message,
    String? details,
    Object? originalError,
  }) : super(
          type: AppErrorType.dataParsing,
          message: message,
          details: details,
          originalError: originalError,
        );
}

/// Erreurs spécifiques pour les ressources introuvables
class NotFoundException extends AppException {
  const NotFoundException({
    required String message,
    String? details,
    Object? originalError,
  }) : super(
          type: AppErrorType.notFound,
          message: message,
          details: details,
          originalError: originalError,
        );
}

/// Erreurs spécifiques pour la validation
class ValidationException extends AppException {
  const ValidationException({
    required String message,
    String? details,
    Object? originalError,
  }) : super(
          type: AppErrorType.validation,
          message: message,
          details: details,
          originalError: originalError,
        );
}
