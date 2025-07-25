import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../ui/theme/app_colors.dart';
import '../ui/theme/app_spacing.dart';
import '../ui/theme/app_text_styles.dart';
import 'app_exceptions.dart';

/// Gestionnaire centralisé des erreurs de l'application
class ErrorHandler {
  /// Convertit une erreur générique en AppException
  static AppException handleError(Object error, {String? context}) {
    if (error is AppException) {
      return error;
    }

    // Détection du type d'erreur basée sur le message et le contexte
    if (error.toString().contains('loadString') || 
        error.toString().contains('assets')) {
      return DataLoadingException(
        message: 'Erreur lors du chargement des assets',
        details: context,
        originalError: error,
      );
    }

    if (error.toString().contains('FormatException') || 
        error.toString().contains('JSON')) {
      return DataParsingException(
        message: 'Erreur de format des données',
        details: context,
        originalError: error,
      );
    }

    if (error is StateError || 
        error.toString().contains('StateError') || 
        error.toString().contains('firstWhere') ||
        error.toString().contains('No element')) {
      return NotFoundException(
        message: 'Ressource introuvable',
        details: context,
        originalError: error,
      );
    }

    // Erreur générique
    return AppException(
      type: AppErrorType.unknown,
      message: 'Une erreur inattendue s\'est produite',
      details: context,
      originalError: error,
    );
  }

  /// Obtient le message d'erreur localisé pour l'utilisateur
  static String getLocalizedMessage(AppException error, AppLocalizations l10n) {
    switch (error.type) {
      case AppErrorType.dataLoading:
        return l10n.errorLoading;
      
      case AppErrorType.dataParsing:
        return l10n.errorDataFormat;
      
      case AppErrorType.notFound:
        // Utilise un message spécifique selon le contexte
        if (error.details?.contains('session') == true) {
          return l10n.errorSessionNotFound;
        }
        if (error.details?.contains('exercise') == true) {
          return l10n.errorNoExercises;
        }
        return l10n.errorNotFound;
      
      case AppErrorType.validation:
        return l10n.errorValidation;
      
      case AppErrorType.network:
        return l10n.errorNetwork;
      
      case AppErrorType.unknown:
      default:
        return l10n.errorUnknown;
    }
  }

  /// Affiche une SnackBar avec le message d'erreur approprié
  static void showErrorSnackBar(
    BuildContext context,
    Object error, {
    String? contextInfo,
    Duration duration = const Duration(seconds: 4),
  }) {
    final l10n = AppLocalizations.of(context)!;
    final appError = handleError(error, context: contextInfo);
    final message = getLocalizedMessage(appError, l10n);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Widget pour afficher une erreur dans l'interface
  static Widget buildErrorWidget(
    Object error,
    AppLocalizations l10n, {
    String? contextInfo,
    VoidCallback? onRetry,
  }) {
    final appError = handleError(error, context: contextInfo);
    final message = getLocalizedMessage(appError, l10n);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getErrorIcon(appError.type),
              size: 64,
              color: AppColors.grey,
            ),
            const SizedBox(height: AppSpacing.gapM),
            Text(
              message,
              style: AppTextStyles.errorMessage,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Retourne l'icône appropriée selon le type d'erreur
  static IconData _getErrorIcon(AppErrorType type) {
    switch (type) {
      case AppErrorType.dataLoading:
        return Icons.cloud_off;
      case AppErrorType.dataParsing:
        return Icons.broken_image;
      case AppErrorType.notFound:
        return Icons.search_off;
      case AppErrorType.validation:
        return Icons.warning;
      case AppErrorType.network:
        return Icons.wifi_off;
      case AppErrorType.unknown:
      default:
        return Icons.error_outline;
    }
  }
}
