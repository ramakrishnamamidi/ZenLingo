import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenlingo/core/providers/database_provider.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/features/profile/providers/settings_provider.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory(), seedOnCreate: false);
  });

  tearDown(() async => db.close());

  test('settingsProvider initial state has defaults', () async {
    final container = ProviderContainer(
      overrides: [
        srsDaoProvider.overrideWithValue(db.srsDao),
      ],
    );
    addTearDown(container.dispose);
    final settings = await container.read(settingsProvider.future);
    expect(settings.notificationsEnabled, isTrue);
    expect(settings.dailyGoal, 20);
  });

  test('setNotifications updates state', () async {
    final container = ProviderContainer(
      overrides: [
        srsDaoProvider.overrideWithValue(db.srsDao),
      ],
    );
    addTearDown(container.dispose);
    await container.read(settingsProvider.future);
    await container.read(settingsProvider.notifier).setNotifications(false);
    final settings = container.read(settingsProvider).value!;
    expect(settings.notificationsEnabled, isFalse);
  });

  test('resetProgress completes without error', () async {
    final container = ProviderContainer(
      overrides: [
        srsDaoProvider.overrideWithValue(db.srsDao),
      ],
    );
    addTearDown(container.dispose);
    await container.read(settingsProvider.future);
    await expectLater(
      container.read(settingsProvider.notifier).resetProgress(),
      completes,
    );
  });
}
