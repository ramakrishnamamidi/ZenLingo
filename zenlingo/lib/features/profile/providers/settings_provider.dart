import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/providers/database_provider.dart';
import '../models/app_settings.dart';

class SettingsNotifier extends AsyncNotifier<AppSettings> {
  static const _notifKey = 'notifications_enabled';
  static const _goalKey = 'daily_goal';

  @override
  Future<AppSettings> build() async {
    final prefs = await SharedPreferences.getInstance();
    return AppSettings(
      notificationsEnabled: prefs.getBool(_notifKey) ?? true,
      dailyGoal: prefs.getInt(_goalKey) ?? 20,
    );
  }

  Future<void> setNotifications(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifKey, enabled);
    state = AsyncData((state.value ?? const AppSettings()).copyWith(
      notificationsEnabled: enabled,
    ));
  }

  Future<void> setDailyGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_goalKey, goal);
    state = AsyncData((state.value ?? const AppSettings()).copyWith(
      dailyGoal: goal,
    ));
  }

  Future<void> resetProgress() async {
    final dao = ref.read(srsDaoProvider);
    await dao.resetProgress();
  }
}

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
