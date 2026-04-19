import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/zen_theme.dart';
import '../../../features/dashboard/providers/stats_provider.dart';
import '../providers/settings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final settingsAsync = ref.watch(settingsProvider);

    if (statsAsync.isLoading || settingsAsync.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final stats = statsAsync.value;
    final settings = settingsAsync.value;

    if (stats == null || settings == null) {
      return const Scaffold(
        body: Center(child: Text('Error loading profile')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('PROFILE')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats section
          Text('Stats', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatTile(label: 'Streak', value: '${stats.streakDays}d'),
                  _StatTile(label: 'Cards', value: '${stats.totalCards}'),
                  _StatTile(label: 'Mastered', value: '${stats.masteredCards}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Settings section
          Text('Settings', style: Theme.of(context).textTheme.titleMedium),
          SwitchListTile(
            title: const Text('Notifications'),
            value: settings.notificationsEnabled,
            onChanged: (v) =>
                ref.read(settingsProvider.notifier).setNotifications(v),
          ),
          ListTile(
            title: const Text('Daily Goal'),
            trailing: Text('${settings.dailyGoal} cards'),
            onTap: () => _showGoalDialog(context, ref, settings.dailyGoal),
          ),
          const SizedBox(height: 24),
          // Danger zone
          Text(
            'Danger Zone',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: ZenTheme.accentRed),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => _confirmReset(context, ref),
            style: OutlinedButton.styleFrom(foregroundColor: ZenTheme.accentRed),
            child: const Text('Reset Progress'),
          ),
        ],
      ),
    );
  }

  Future<void> _showGoalDialog(
      BuildContext context, WidgetRef ref, int current) async {
    final chosen = await showDialog<int>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Daily Goal'),
        children: [10, 20, 30]
            .map((n) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, n),
                  child: Text('$n cards'),
                ))
            .toList(),
      ),
    );
    if (chosen != null && context.mounted) {
      ref.read(settingsProvider.notifier).setDailyGoal(chosen);
    }
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progress'),
        content: const Text('Reset all SRS progress? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: ZenTheme.accentRed),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref.read(settingsProvider.notifier).resetProgress();
    }
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineSmall),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
