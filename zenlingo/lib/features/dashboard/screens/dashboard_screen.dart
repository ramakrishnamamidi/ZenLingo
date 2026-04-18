import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/stats_provider.dart';
import '../widgets/activity_heatmap.dart';
import '../widgets/mastery_gauge.dart';
import '../widgets/streak_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(dashboardStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('TODAY')),
      body: asyncStats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (stats) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreakWidget(streakDays: stats.streakDays),
                  MasteryGauge(
                    percent: stats.masteryPercent,
                    masteredCards: stats.masteredCards,
                    totalCards: stats.totalCards,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'ACTIVITY',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              ActivityHeatmap(heatmapData: stats.heatmapData),
            ],
          ),
        ),
      ),
    );
  }
}
