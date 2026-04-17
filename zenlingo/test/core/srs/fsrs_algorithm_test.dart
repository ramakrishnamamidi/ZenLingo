import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/srs/fsrs_algorithm.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/data/database/app_database.dart';

VocabularyCard makeCard({
  int reps = 0,
  double stability = 1.0,
  double difficulty = 5.0,
  double retrievability = 1.0,
  int interval = 1,
  DateTime? lastReview,
}) =>
    VocabularyCard(
      id: 1,
      word: 'テスト',
      reading: 'てすと',
      meaning: 'test',
      exampleSentence: null,
      jlptLevel: 5,
      languageCode: 'ja',
      stability: stability,
      difficulty: difficulty,
      retrievability: retrievability,
      reps: reps,
      easinessFactor: 2.5,
      interval: interval,
      nextReviewDate: DateTime.now(),
      lastReviewDate: lastReview,
      tags: '[]',
    );

void main() {
  late FsrsAlgorithm algo;

  setUp(() {
    algo = FsrsAlgorithm();
  });

  group('new card (reps == 0)', () {
    test('again: low stability (~0.4 days)', () {
      final result = algo.schedule(makeCard(), SrsGrade.again);
      expect(result.stability, closeTo(0.41, 0.1));
      expect(result.interval, 1);
      expect(result.reps, 1);
    });

    test('good: medium stability (~3.1 days)', () {
      final result = algo.schedule(makeCard(), SrsGrade.good);
      expect(result.stability, closeTo(3.1, 0.5));
      expect(result.interval, greaterThanOrEqualTo(3));
    });

    test('easy: high stability (~15 days)', () {
      final result = algo.schedule(makeCard(), SrsGrade.easy);
      expect(result.stability, closeTo(15.5, 2.0));
      expect(result.interval, greaterThanOrEqualTo(12));
    });

    test('good difficulty > easy difficulty (harder to start)', () {
      final goodResult = algo.schedule(makeCard(), SrsGrade.good);
      final easyResult = algo.schedule(makeCard(), SrsGrade.easy);
      expect(goodResult.difficulty, greaterThan(easyResult.difficulty));
    });
  });

  group('review card (reps > 0)', () {
    test('good review increases stability', () {
      final card = makeCard(
        reps: 3,
        stability: 10.0,
        difficulty: 5.0,
        lastReview: DateTime.now().subtract(const Duration(days: 10)),
      );
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.stability, greaterThan(card.stability));
    });

    test('again review decreases stability', () {
      final card = makeCard(
        reps: 3,
        stability: 10.0,
        difficulty: 5.0,
        lastReview: DateTime.now().subtract(const Duration(days: 10)),
      );
      final result = algo.schedule(card, SrsGrade.again);
      expect(result.stability, lessThan(card.stability));
    });

    test('easy interval > good interval', () {
      final card = makeCard(
        reps: 2,
        stability: 5.0,
        difficulty: 5.0,
        lastReview: DateTime.now().subtract(const Duration(days: 5)),
      );
      final goodResult = algo.schedule(card, SrsGrade.good);
      final easyResult = algo.schedule(card, SrsGrade.easy);
      expect(easyResult.interval, greaterThan(goodResult.interval));
    });

    test('nextReviewDate is in the future', () {
      final card = makeCard(
        reps: 1,
        stability: 3.0,
        lastReview: DateTime.now().subtract(const Duration(days: 3)),
      );
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.nextReviewDate.isAfter(DateTime.now()), isTrue);
    });

    test('difficulty stays in [1.0, 10.0] after repeated again grades', () {
      var card = makeCard(reps: 1, stability: 2.0, difficulty: 9.5);
      for (int i = 0; i < 5; i++) {
        card = algo.schedule(card, SrsGrade.again);
      }
      expect(card.difficulty, lessThanOrEqualTo(10.0));
      expect(card.difficulty, greaterThanOrEqualTo(1.0));
    });
  });
}
