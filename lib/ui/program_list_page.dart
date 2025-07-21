import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_dimensions.dart';
import 'package:go_router/go_router.dart';
import '../data/json_loader.dart';
import '../data/program_model.dart';

/// Page d'accueil affichant la liste des programmes disponibles
class ProgramListPage extends StatelessWidget {
  const ProgramListPage({super.key});

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

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Erreur de chargement',
                  style: AppTextStyles.exerciseTitle,
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'Aucun programme',
                  style: AppTextStyles.exerciseTitle,
                ),
              );
            }

            final program = snapshot.data!;

            return GestureDetector(
              onTap: () => context.go('/sessions'),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.white,
                child: Center(
                  child: Text(
                    program.name,
                    style: AppTextStyles.exerciseTitle.copyWith(color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
