import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/providers/database_provider.dart';
import 'package:zenlingo/core/providers/srs_algorithm_provider.dart';
import 'package:zenlingo/core/srs/fsrs_algorithm.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/data/database/daos/srs_dao.dart';
import 'package:zenlingo/features/srs/providers/srs_provider.dart';

VocabularyCardsCompanion _card({required String word, DateTime? nextReview}) =>
    VocabularyCardsCompanion.insert(
      word: word,
      reading: 'てすと',
      meaning: 'test',
      nextReviewDate: Value(
        nextReview ?? DateTime.now().subtract(const Duration(hours: 1)),
      ),
    );

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory(), seedOnCreate: false);
    container = ProviderContainer(
      overrides: [
        srsDaoProvider.overrideWithValue(db.srsDao),
        srsAlgorithmProvider.overrideWithValue(FsrsAlgorithm()),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('build returns due cards', () async {
    await db.srsDao.insertCard(_card(word: '水'));
    final cards = await container.read(srsReviewSessionProvider.future);
    expect(cards.length, 1);
    expect(cards.first.word, '水');
  });

  test('build excludes future cards', () async {
    await db.srsDao.insertCard(_card(
      word: '火',
      nextReview: DateTime.now().add(const Duration(days: 7)),
    ));
    final cards = await container.read(srsReviewSessionProvider.future);
    expect(cards, isEmpty);
  });

  test('gradeCard updates card and invalidates session', () async {
    await db.srsDao.insertCard(_card(word: '水'));
    final before = await container.read(srsReviewSessionProvider.future);
    expect(before.length, 1);

    await container
        .read(srsReviewSessionProvider.notifier)
        .gradeCard(before.first, SrsGrade.good);

    final after = await container.read(srsReviewSessionProvider.future);
    expect(after, isEmpty); // card rescheduled to future
  });
}
