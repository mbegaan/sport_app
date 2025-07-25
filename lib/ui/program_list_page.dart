import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/json_loader.dart';
import '../data/program_model.dart';
import '../l10n/app_localizations.dart';
import '../utils/error_handler.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_dimensions.dart';

/// Page d'accueil affichant la liste des programmes disponibles
class ProgramListPage extends StatefulWidget {
  const ProgramListPage({super.key});

  @override
  State<ProgramListPage> createState() => _ProgramListPageState();
}

class _ProgramListPageState extends State<ProgramListPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
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
              return ErrorHandler.buildErrorWidget(
                snapshot.error!,
                l10n,
                contextInfo: 'ProgramListPage.loadProgram',
                onRetry: () {
                  setState(() {}); // Force rebuild pour relancer FutureBuilder
                },
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  l10n.noProgram,
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
