import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/core/srs/sm2_algorithm.dart';
import 'package:zenlingo/data/database/app_database.dart';

VocabularyCard makeCard({
  int reps = 0,
  double easinessFactor = 2.5,
  int interval = 1,
  DateTime? lastReview,
}) {
  return VocabularyCard(
    id: 1,
    word: 'テスト',
    reading: 'てすと',
    meaning: 'test',
    exampleSentence: null,
    jlptLevel: 5,
    languageCode: 'ja',
    stability: 1.0,
    difficulty: 5.0,
    retrievability: 1.0,
    reps: reps,
    easinessFactor: easinessFactor,
    interval: interval,
    nextReviewDate: DateTime.now(),
    lastReviewDate: lastReview,
    tags: '[]',
  );
}

void main() {
  late Sm2Algorithm algo;

  setUp(() {
    algo = Sm2Algorithm();
  });

  group('new card (reps == 0)', () {
    test('again resets interval to 1 and reps to 0', () {
      final card = makeCard(reps: 0);
      final result = algo.schedule(card, SrsGrade.again);
      expect(result.interval, 1);
      expect(result.reps, 0);
    });

    test('good sets interval to 1 and increments reps', () {
      final card = makeCard(reps: 0);
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.interval, 1);
      expect(result.reps, 1);
    });

    test('easy sets interval to 4', () {
      final card = makeCard(reps: 0);
      final result = algo.schedule(card, SrsGrade.easy);
      expect(result.interval, 4);
      expect(result.reps, 1);
    });
  });

  group('second review (reps == 1)', () {
    test('good sets interval to 6', () {
      final card = makeCard(reps: 1, interval: 1);
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.interval, 6);
      expect(result.reps, 2);
    });
  });

  group('subsequent reviews (reps >= 2)', () {
    test('good multiplies interval by EF (2.5 * 6 = 15)', () {
      final card = makeCard(reps: 2, easinessFactor: 2.5, interval: 6);
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.interval, 15);
    });

    test('again resets reps and interval', () {
      final card = makeCard(reps: 5, easinessFactor: 2.5, interval: 30);
      final result = algo.schedule(card, SrsGrade.again);
      expect(result.reps, 0);
      expect(result.interval, 1);
    });

    test('hard grade decreases EF', () {
      final card = makeCard(reps: 3, easinessFactor: 2.5, interval: 10);
      final result = algo.schedule(card, SrsGrade.hard);
      expect(result.easinessFactor, lessThan(2.5));
      expect(result.easinessFactor, greaterThanOrEqualTo(1.3));
    });

    test('easy grade increases EF', () {
      final card = makeCard(reps: 3, easinessFactor: 2.5, interval: 10);
      final result = algo.schedule(card, SrsGrade.easy);
      expect(result.easinessFactor, greaterThan(2.5));
    });

    test('EF never drops below 1.3', () {
      final card = makeCard(reps: 10, easinessFactor: 1.3, interval: 5);
      final result = algo.schedule(card, SrsGrade.hard);
      expect(result.easinessFactor, greaterThanOrEqualTo(1.3));
    });
  });

  test('nextReviewDate is in the future', () {
    final card = makeCard(reps: 0);
    final result = algo.schedule(card, SrsGrade.good);
    expect(result.nextReviewDate.isAfter(DateTime.now()), isTrue);
  });
}
