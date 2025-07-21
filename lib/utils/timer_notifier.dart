import 'dart:async';
import 'package:flutter/material.dart';

/// Notifier pour gérer les timers (chrono et repos)
class TimerNotifier extends ValueNotifier<TimerState> {
  Timer? _timer;
  
  TimerNotifier() : super(TimerState.idle());

  /// Démarre un chrono pour un exercice de durée
  void startExerciseTimer(int durationSec) {
    _stopTimer();
    
    value = TimerState.exerciseRunning(durationSec, durationSec);
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newRemaining = value.remainingSeconds - 1;
      
      if (newRemaining <= 0) {
        timer.cancel();
        value = TimerState.exerciseCompleted();
      } else {
        value = TimerState.exerciseRunning(durationSec, newRemaining);
      }
    });
  }

  /// Démarre un timer de repos
  void startRestTimer(int restDurationSec) {
    _stopTimer();
    
    value = TimerState.restRunning(restDurationSec, restDurationSec);
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newRemaining = value.remainingSeconds - 1;
      
      if (newRemaining <= 0) {
        timer.cancel();
        value = TimerState.restCompleted();
      } else {
        value = TimerState.restRunning(restDurationSec, newRemaining);
      }
    });
  }

  /// Arrête le timer actuel
  void stopTimer() {
    _stopTimer();
    value = TimerState.idle();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}

/// État du timer
class TimerState {
  final TimerType type;
  final int totalSeconds;
  final int remainingSeconds;

  const TimerState({
    required this.type,
    required this.totalSeconds,
    required this.remainingSeconds,
  });

  factory TimerState.idle() {
    return const TimerState(
      type: TimerType.idle,
      totalSeconds: 0,
      remainingSeconds: 0,
    );
  }

  factory TimerState.exerciseRunning(int total, int remaining) {
    return TimerState(
      type: TimerType.exerciseRunning,
      totalSeconds: total,
      remainingSeconds: remaining,
    );
  }

  factory TimerState.exerciseCompleted() {
    return const TimerState(
      type: TimerType.exerciseCompleted,
      totalSeconds: 0,
      remainingSeconds: 0,
    );
  }

  factory TimerState.restRunning(int total, int remaining) {
    return TimerState(
      type: TimerType.restRunning,
      totalSeconds: total,
      remainingSeconds: remaining,
    );
  }

  factory TimerState.restCompleted() {
    return const TimerState(
      type: TimerType.restCompleted,
      totalSeconds: 0,
      remainingSeconds: 0,
    );
  }

  bool get isRunning => type == TimerType.exerciseRunning || type == TimerType.restRunning;
  bool get isIdle => type == TimerType.idle;
  bool get isExerciseCompleted => type == TimerType.exerciseCompleted;
  bool get isRestCompleted => type == TimerType.restCompleted;
  bool get isRest => type == TimerType.restRunning || type == TimerType.restCompleted;

  /// Retourne le pourcentage de progression (0.0 à 1.0)
  double get progress {
    if (totalSeconds == 0) return 0.0;
    return (totalSeconds - remainingSeconds) / totalSeconds;
  }

  /// Formate le temps restant en MM:SS
  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

enum TimerType {
  idle,
  exerciseRunning,
  exerciseCompleted,
  restRunning,
  restCompleted,
}
