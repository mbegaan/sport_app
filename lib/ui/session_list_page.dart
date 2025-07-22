import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_dimensions.dart';
import 'theme/app_spacing.dart';
import 'widgets/app_button.dart';
import 'widgets/responsive_builder.dart';
import 'package:go_router/go_router.dart';
import '../data/json_loader.dart';
import '../data/program_model.dart';
import '../l10n/app_localizations.dart';
import '../utils/error_handler.dart';

/// Page affichant la liste des séances d'un programme
class SessionListPage extends StatefulWidget {
  const SessionListPage({super.key});

  @override
  State<SessionListPage> createState() => _SessionListPageState();
}

class _SessionListPageState extends State<SessionListPage> {
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

            if (snapshot.hasError || !snapshot.hasData) {
              return ErrorHandler.buildErrorWidget(
                snapshot.error ?? Exception(l10n.noProgram),
                l10n,
                contextInfo: 'SessionListPage.loadProgram',
                onRetry: () {
                  JsonLoader.clearCache();
                  setState(() {}); // Force rebuild pour relancer FutureBuilder
                },
              );
            }

            final sessions = snapshot.data!.sessions;

            return ResponsiveBuilder(
              builder: (context, screenWidth) {
                final padding = AppDimensions.paddingResponsive(screenWidth);
                
                return ListView.builder(
                  padding: EdgeInsets.all(padding),
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
            );
          },
        ),
      ),
    );
  }
}
