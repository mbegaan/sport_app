import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class RestTimer extends StatelessWidget {
  final int seconds;
  final bool isRunning;

  const RestTimer({
    super.key,
    required this.seconds,
    this.isRunning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isRunning ? '$seconds s' : 'Repos',
        style: AppTextStyles.exerciseTitle,
      ),
    );
  }
}
