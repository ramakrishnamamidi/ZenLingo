import 'package:flutter/material.dart';

import '../../../core/theme/zen_theme.dart';

class MasteryGauge extends StatelessWidget {
  final double percent; // 0.0 to 1.0
  final int masteredCards;
  final int totalCards;

  const MasteryGauge({
    super.key,
    required this.percent,
    required this.masteredCards,
    required this.totalCards,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: percent,
                strokeWidth: 8,
                backgroundColor: ZenTheme.bgSurface,
                color: ZenTheme.accentRed,
              ),
              Text(
                '${(percent * 100).round()}%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$masteredCards / $totalCards mastered',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
