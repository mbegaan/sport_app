import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_dimensions.dart';
import 'theme/app_spacing.dart';
import 'widgets/app_button.dart';
import 'widgets/app_scaffold.dart';
import 'package:go_router/go_router.dart';
import '../data/json_loader.dart';
import '../data/program_model.dart';

/// Page affichant la liste des séances d'un programme
class SessionListPage extends StatelessWidget {
  const SessionListPage({super.key});

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
                child: CircularProgressIndicator(
                  strokeWidth: AppDimensions.strokeWidth,
                  color: AppColors.black,
                ),
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

            final sessions = snapshot.data!.sessions;

            return ListView.builder(
              padding: EdgeInsets.all(AppDimensions.mainPadding),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.gapL),
                  child: AppButton(
                    label: session.name,
                    onPressed: () => context.go('/session/${session.id}'),
                    type: AppButtonType.primary,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
