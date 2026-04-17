import 'dart:math';

import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'srs_algorithm.dart';

class Sm2Algorithm implements SrsAlgorithm {
  static const Map<SrsGrade, int> _qualityMap = {
    SrsGrade.again: 1,
    SrsGrade.hard: 3,
    SrsGrade.good: 4,
    SrsGrade.easy: 5,
  };

  @override
  VocabularyCard schedule(VocabularyCard card, SrsGrade grade) {
    final q = _qualityMap[grade]!;

    if (q < 3) {
      return card.copyWith(
        reps: 0,
        interval: 1,
        lastReviewDate: Value(DateTime.now()),
        nextReviewDate: DateTime.now().add(const Duration(days: 1)),
      );
    }

    // EF' = max(1.3, EF + 0.1 - (5-q)(0.08 + (5-q)*0.02))
    final newEf = max(
      1.3,
      card.easinessFactor + 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02),
    );

    final newReps = card.reps + 1;
    final int newInterval;

    if (newReps == 1) {
      newInterval = grade == SrsGrade.easy ? 4 : 1;
    } else if (newReps == 2) {
      newInterval = 6;
    } else {
      newInterval = (card.interval * newEf).round();
    }

    return card.copyWith(
      reps: newReps,
      easinessFactor: newEf,
      interval: newInterval,
      lastReviewDate: Value(DateTime.now()),
      nextReviewDate: DateTime.now().add(Duration(days: newInterval)),
    );
  }
}
