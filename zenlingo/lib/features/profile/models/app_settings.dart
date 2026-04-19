class AppSettings {
  final bool notificationsEnabled;
  final int dailyGoal;

  const AppSettings({
    this.notificationsEnabled = true,
    this.dailyGoal = 20,
  });

  AppSettings copyWith({bool? notificationsEnabled, int? dailyGoal}) =>
      AppSettings(
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        dailyGoal: dailyGoal ?? this.dailyGoal,
      );
}
