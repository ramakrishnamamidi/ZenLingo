import 'package:flutter/material.dart';

import '../../../core/theme/zen_theme.dart';

class StreakWidget extends StatelessWidget {
  final int streakDays;

  const StreakWidget({super.key, required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.local_fire_department, color: ZenTheme.accentRed, size: 40),
        const SizedBox(height: 4),
        Text(
          '$streakDays',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text('day streak', style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
