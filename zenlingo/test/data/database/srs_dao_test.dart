import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/srs/fsrs_algorithm.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/data/database/daos/srs_dao.dart';

VocabularyCardsCompanion makeCompanion({
  required String word,
  DateTime? nextReview,
}) =>
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
  late SrsDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory(), seedOnCreate: false);
    dao = db.srsDao;
  });

  tearDown(() async => db.close());

  test('getDueCards returns card with past nextReviewDate', () async {
    await dao.insertCard(makeCompanion(word: '水'));
    final cards = await dao.getDueCards();
    expect(cards.length, 1);
    expect(cards.first.word, '水');
  });

  test('getDueCards excludes future cards', () async {
    await dao.insertCard(makeCompanion(
      word: '火',
      nextReview: DateTime.now().add(const Duration(days: 7)),
    ));
    final cards = await dao.getDueCards();
    expect(cards, isEmpty);
  });

  test('updateCard persists new scheduling data', () async {
    await dao.insertCard(makeCompanion(word: '水'));
    final before = (await dao.getDueCards()).first;

    final algo = FsrsAlgorithm();
    final updated = algo.schedule(before, SrsGrade.good);
    await dao.updateCard(updated);

    final after = await (db.select(db.vocabularyCards)
          ..where((c) => c.id.equals(before.id)))
        .getSingle();

    expect(after.stability, greaterThan(before.stability));
    expect(after.reps, 1);
    expect(after.nextReviewDate.isAfter(DateTime.now()), isTrue);
  });

  test('countAllCards returns correct count', () async {
    await dao.insertCard(makeCompanion(word: '水'));
    await dao.insertCard(makeCompanion(word: '火'));
    expect(await dao.countAllCards(), 2);
  });

  test('watchDueCards stream reflects updateCard', () async {
    await dao.insertCard(makeCompanion(word: '水'));

    final stream = dao.watchDueCards();
    final first = await stream.first;
    expect(first.length, 1);

    final algo = FsrsAlgorithm();
    final updated = algo.schedule(first.first, SrsGrade.good);
    await dao.updateCard(updated);

    final second = await stream.first;
    expect(second, isEmpty);
  });
}
