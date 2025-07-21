import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_dimensions.dart';
import 'theme/app_spacing.dart';
import 'widgets/app_button.dart';
import 'widgets/exercise_card.dart';
import 'package:go_router/go_router.dart';
import '../data/json_loader.dart';
import '../data/program_model.dart';

/// Page affichant l'aperçu d'une séance avec la liste des exercices
class SessionOverviewPage extends StatelessWidget {
  final String sessionId;

  const SessionOverviewPage({
    super.key,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: FutureBuilder<Program>(
          future: JsonLoader.loadProgram(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: AppDimensions.strokeWidth),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(
                child: Text(
                  'Erreur de chargement',
                  style: AppTextStyles.exerciseTitle,
                ),
              );
            }

            final program = snapshot.data!;
            late Session session;
            try {
              session = program.sessions.firstWhere(
                (s) => s.id.toString() == sessionId,
              );
            } catch (e) {
              return const Center(
                child: Text(
                  'Séance introuvable',
                  style: AppTextStyles.exerciseTitle,
                ),
              );
            }

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
                              '${session.exercises.length} exercices',
                              style: AppTextStyles.exerciseTitle.copyWith(color: AppColors.black),
                            ),
                          ),
                          
                          const SizedBox(height: AppDimensions.sectionSpacing),
                          
                          // Bouton principal - point focal unique
                          AppButton(
                            label: 'COMMENCER',
                            onPressed: () => context.go('/workout/${session.id}'),
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
