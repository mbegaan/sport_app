import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_dimensions.dart';
import 'theme/app_spacing.dart';
import 'widgets/app_button.dart';
import 'package:go_router/go_router.dart';
import '../data/json_loader.dart';
import '../data/program_model.dart';
import '../l10n/app_localizations.dart';
import '../utils/error_handler.dart';
import '../utils/app_exceptions.dart';

/// Page affichant l'aperçu d'une séance avec la liste des exercices
class SessionOverviewPage extends StatefulWidget {
  final String sessionId;

  const SessionOverviewPage({
    super.key,
    required this.sessionId,
  });

  @override
  State<SessionOverviewPage> createState() => _SessionOverviewPageState();
}

class _SessionOverviewPageState extends State<SessionOverviewPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: FutureBuilder<Session>(
          future: JsonLoader.getSession(widget.sessionId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: AppDimensions.strokeWidth),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return ErrorHandler.buildErrorWidget(
                snapshot.error ?? Exception(l10n.noProgram),
                l10n,
                contextInfo: 'SessionOverviewPage.loadSession',
                onRetry: () {
                  setState(() {}); // Force rebuild pour relancer FutureBuilder
                },
              );
            }

            final session = snapshot.data!;

            return Column(
              children: [
                // Header avec navigation
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.mainPadding),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/sessions'),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.gapM),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.gapM),
                      Expanded(
                        child: Text(
                          session.name,
                          style: AppTextStyles.exerciseTitle.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),

                // Focus central : bouton de démarrage
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.sectionSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Info minimale
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.mainPadding, 
                              vertical: AppSpacing.gapM
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                            ),
                            child: Text(
                              l10n.exercisesCount(session.exercises.length),
                              style: AppTextStyles.exerciseTitle.copyWith(color: AppColors.black),
                            ),
                          ),
                          
                          const SizedBox(height: AppDimensions.sectionSpacing),
                          
                          // Bouton principal - point focal unique
                          AppButton(
                            label: l10n.startButton,
                            onPressed: () {
                              if (session.exercises.isEmpty) {
                                ErrorHandler.showErrorSnackBar(
                                  context,
                                  ValidationException(
                                    message: 'Aucun exercice dans cette séance',
                                    details: 'session_id:${widget.sessionId}',
                                  ),
                                  contextInfo: 'SessionOverviewPage.startWorkout',
                                );
                                return;
                              }
                              context.go('/workout/${session.id}');
                            },
                            type: AppButtonType.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
