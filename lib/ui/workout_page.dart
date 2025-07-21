import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/json_loader.dart';
import '../data/program_model.dart';
import '../utils/timer_notifier.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_dimensions.dart';
import 'theme/app_spacing.dart';
import 'widgets/app_button.dart';
import 'widgets/exercise_progress_header.dart';
import 'widgets/rep_counter.dart';
import 'widgets/rep_controls.dart';
import 'animations/breathing_animation.dart';
import 'animations/effort_animation.dart';

/// Page principale d'exercice par exercice
class WorkoutPage extends StatefulWidget {
  final String sessionId;

  const WorkoutPage({
    super.key,
    required this.sessionId,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late TimerNotifier _timerNotifier;
  Session? _session;
  int _currentExerciseIndex = 0;
  int _currentSet = 1;
  int _completedReps = 0;
  bool _isLoading = true;
  bool _isWorkoutComplete = false;

  @override
  void initState() {
    super.initState();
    _timerNotifier = TimerNotifier();
    _loadSession();
    
    // Écouter les changements du timer
    _timerNotifier.addListener(_onTimerChange);
  }

  @override
  void dispose() {
    _timerNotifier.removeListener(_onTimerChange);
    _timerNotifier.dispose();
    super.dispose();
  }

  void _onTimerChange() {
    if (_timerNotifier.value.isExerciseCompleted) {
      _handleExerciseCompleted();
    } else if (_timerNotifier.value.isRestCompleted) {
      _handleRestCompleted();
    }
  }

  Future<void> _loadSession() async {
    try {
      final program = await JsonLoader.loadProgram();
      final session = program.sessions.firstWhere(
        (s) => s.id.toString() == widget.sessionId,
      );
      setState(() {
        _session = session;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleExerciseCompleted() {
    // Auto-avancer à la série suivante ou exercice suivant
    Future.delayed(const Duration(seconds: 1), () {
      _completeCurrentSet();
    });
  }

  void _handleRestCompleted() {
    // Le repos est terminé, transition automatique après 1 seconde
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _timerNotifier.stopTimer();
        setState(() {
          // Force le rebuild pour revenir à l'interface d'exercice
        });
      }
    });
  }

  void _completeCurrentSet() {
    if (_session == null) return;

    final currentExercise = _session!.exercises[_currentExerciseIndex];
    
    if (_currentSet < currentExercise.numberOfSets) {
      // Passer à la série suivante
      _startRestTimer();
      setState(() {
        _currentSet++;
        _completedReps = 0;
      });
    } else {
      // Exercice terminé, passer au suivant
      _nextExercise();
    }
  }

  void _nextExercise() {
    if (_session == null) return;

    if (_currentExerciseIndex < _session!.exercises.length - 1) {
      // Démarrer un repos entre exercices avant de passer au suivant
      _timerNotifier.startRestTimer(8); // 8 secondes de repos entre exercices
      setState(() {
        _currentExerciseIndex++;
        _currentSet = 1;
        _completedReps = 0;
      });
    } else {
      // Séance terminée !
      _completeWorkout();
    }
  }

  void _startRestTimer() {
    _timerNotifier.startRestTimer(4); // 4 secondes de repos inter-série
  }

  void _completeWorkout() {
    setState(() {
      _isWorkoutComplete = true;
    });
    
    _timerNotifier.stopTimer();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Séance terminée 🎉 Félicitations !',
          style: AppTextStyles.button,
        ),
        backgroundColor: AppColors.grey,
        duration: const Duration(seconds: 3),
      ),
    );
    
    // Retourner à l'accueil après 3 secondes
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: AppDimensions.strokeWidth,
            color: AppColors.black,
          ),
        ),
      );
    }

    if (_session == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Text(
            'Séance introuvable',
            style: AppTextStyles.errorMessage,
          ),
        ),
      );
    }

    if (_isWorkoutComplete) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: AppDimensions.iconSizeLarge,
                color: AppColors.white,
              ),
              SizedBox(height: AppSpacing.gapXL),
              Text(
                'Séance terminée',
                style: AppTextStyles.completionTitle,
              ),
              SizedBox(height: AppSpacing.gapM),
              Text(
                'Félicitations !',
                style: AppTextStyles.completionSubtitle,
              ),
            ],
          ),
        ),
      );
    }

    final currentExercise = _session!.exercises[_currentExerciseIndex];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ValueListenableBuilder<TimerState>(
          valueListenable: _timerNotifier,
          builder: (context, timerState, child) {
            // Si on est en repos, afficher seulement l'interface de repos
            if (timerState.isRest) {
              return _buildRestContent(timerState);
            }
            
            // Interface normale d'exercice
            return Column(
              children: [
                // En-tête avec bouton retour et progression
                Padding(
                  padding: EdgeInsets.all(AppDimensions.mainPadding),
                  child: Row(
                    children: [
                      // Bouton retour discret
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: Container(
                          padding: EdgeInsets.all(AppSpacing.gapS),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                            border: Border.all(color: AppColors.black, width: AppDimensions.borderWidth),
                          ),
                          child: Icon(
                            Icons.close,
                            size: AppDimensions.iconSizeSmall,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Spacer(),
                      SizedBox(width: AppSpacing.gapXL), // Balance visuelle
                    ],
                  ),
                ),
                
                // Exercice avec fractions
                ExerciseProgressHeader(
                  currentExerciseIndex: _currentExerciseIndex,
                  totalExercises: _session!.exercises.length,
                  exerciseName: currentExercise.name,
                  currentSet: _currentSet,
                  totalSets: currentExercise.numberOfSets,
                ),
                
                SizedBox(height: AppDimensions.sectionSpacing),
                
                // Zone principale centrée sur l'exercice
                Expanded(
                  child: _buildExerciseContent(currentExercise, timerState),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExerciseContent(Exercise exercise, TimerState timerState) {
    if (exercise.isDurationBased) {
      return _buildDurationExerciseContent(exercise, timerState);
    } else {
      return _buildRepsExerciseContent(exercise, timerState);
    }
  }

  Widget _buildRestContent(TimerState timerState) {
    // Interface de repos en plein écran noir absolu
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: timerState.isRunning 
          ? const BreathingAnimation()
          : const SizedBox(), // Rien après le repos
      ),
    );
  }

  Widget _buildDurationExerciseContent(Exercise exercise, TimerState timerState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (timerState.isRunning) ...[
            // Animation d'effort - disque qui se réduit
            EffortAnimation(progress: timerState.progress),
          ] else if (timerState.isExerciseCompleted) ...[
            Icon(
              Icons.check_circle_outline,
              size: AppDimensions.iconSizeLarge,
              color: AppColors.black,
            ),
          ] else ...[
            // Bouton de démarrage - action principale
            SizedBox(
              width: AppDimensions.startButtonWidth,
              child: AppButton(
                label: 'DÉMARRER',
                onPressed: () => _timerNotifier.startExerciseTimer(exercise.exerciseDuration!),
                type: AppButtonType.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRepsExerciseContent(Exercise exercise, TimerState timerState) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mainPadding + AppSpacing.gapM),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Compteur central - focus unique
          RepCounter(count: _completedReps),
          
          SizedBox(height: AppDimensions.sectionSpacing),
          
          // Contrôles minimalistes
          RepControls(
            onDecrement: _completedReps > 0 
                ? () => setState(() => _completedReps--) 
                : null,
            onIncrement: () => setState(() => _completedReps++),
            onValidate: _completeCurrentSet,
            canValidate: _completedReps > 0,
          ),
        ],
      ),
    );
  }

  void _showExitDialog() {
    // Navigation directe sans confirmation
    context.go('/');
  }
}