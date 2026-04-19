import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/theme/zen_theme.dart';
import 'package:zenlingo/features/dashboard/models/dashboard_stats.dart';
import 'package:zenlingo/features/dashboard/providers/stats_provider.dart';
import 'package:zenlingo/features/profile/models/app_settings.dart';
import 'package:zenlingo/features/profile/providers/settings_provider.dart';
import 'package:zenlingo/features/profile/screens/profile_screen.dart';

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  Future<AppSettings> build() async =>
      const AppSettings(notificationsEnabled: true, dailyGoal: 20);
}

void main() {
  testWidgets('ProfileScreen shows stats', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dashboardStatsProvider.overrideWith(
            (ref) async => DashboardStats(
              streakDays: 5,
              totalCards: 100,
              masteredCards: 30,
              masteryPercent: 0.3,
              heatmapData: {},
            ),
          ),
          settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
        ],
        child: MaterialApp(
          theme: ZenTheme.dark,
          home: const ProfileScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('5d'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
  });

  testWidgets('ProfileScreen shows settings', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dashboardStatsProvider.overrideWith(
            (ref) async => DashboardStats(
              streakDays: 0,
              totalCards: 0,
              masteredCards: 0,
              masteryPercent: 0.0,
              heatmapData: {},
            ),
          ),
          settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
        ],
        child: MaterialApp(
          theme: ZenTheme.dark,
          home: const ProfileScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.text('Daily Goal'), findsOneWidget);
    expect(find.text('20 cards'), findsOneWidget);
  });
}
