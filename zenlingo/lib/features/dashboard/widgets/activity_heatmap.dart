import 'package:flutter/material.dart';

import '../../../core/theme/zen_theme.dart';

class ActivityHeatmap extends StatelessWidget {
  final Map<String, int> heatmapData;

  const ActivityHeatmap({super.key, required this.heatmapData});

  String _key(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Color _cellColor(int count) {
    if (count == 0) return ZenTheme.heatmapMin;
    if (count < 10) return Color.lerp(ZenTheme.heatmapMin, ZenTheme.heatmapMax, 0.3)!;
    if (count < 30) return Color.lerp(ZenTheme.heatmapMin, ZenTheme.heatmapMax, 0.6)!;
    return ZenTheme.heatmapMax;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(52, (week) {
          return Column(
            children: List.generate(7, (dayOfWeek) {
              final offset = (51 - week) * 7 + (6 - dayOfWeek);
              final day = today.subtract(Duration(days: offset));
              final count = heatmapData[_key(day)] ?? 0;
              return Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: _cellColor(count),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
