import 'dart:math';

import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import 'srs_algorithm.dart';

class FsrsAlgorithm implements SrsAlgorithm {
  // FSRS-4.5 default weights
  static const List<double> _w = [
    0.4072, 1.1829, 3.1262, 15.4722, // w0-w3: initial stability per grade (again/hard/good/easy)
    7.2102, // w4: initial difficulty base
    0.5316, // w5: difficulty adjustment per grade step
    1.0651, 0.0589, // w6-w7 (unused in simplified form)
    1.5330, 0.1544, 1.0012, // w8-w10: stability increase formula
    1.9395, 0.1100, 0.2900, 2.2700, // w11-w14: stability after failure
    0.2900, 2.9898, // w15-w16: hard/easy modifiers
  ];

  @override
  VocabularyCard schedule(VocabularyCard card, SrsGrade grade) {
    final gradeIdx = grade.index; // 0=again 1=hard 2=good 3=easy
    final fsrsGrade = gradeIdx + 1; // FSRS uses 1-based grades

    if (card.reps == 0) {
      return _scheduleNew(card, gradeIdx, fsrsGrade);
    }
    return _scheduleReview(card, gradeIdx, fsrsGrade);
  }

  VocabularyCard _scheduleNew(
      VocabularyCard card, int gradeIdx, int fsrsGrade) {
    final s = _w[gradeIdx];
    final d = (_w[4] - _w[5] * (fsrsGrade - 3)).clamp(1.0, 10.0);
    final interval = max(1, s.round());

    return card.copyWith(
      stability: s,
      difficulty: d,
      retrievability: exp(-interval.toDouble() / s),
      reps: 1,
      interval: interval,
      lastReviewDate: Value(DateTime.now()),
      nextReviewDate: DateTime.now().add(Duration(days: interval)),
    );
  }

  VocabularyCard _scheduleReview(
      VocabularyCard card, int gradeIdx, int fsrsGrade) {
    final elapsed = card.lastReviewDate != null
        ? DateTime.now().difference(card.lastReviewDate!).inDays.toDouble()
        : 1.0;
    final r = exp(-elapsed / card.stability);

    final double newS;
    if (gradeIdx == 0) {
      // Again — forgot
      newS = _w[11] *
          pow(card.difficulty, -_w[12]) *
          (pow(card.stability + 1, _w[13]) - 1) *
          exp(_w[14] * (1 - r));
    } else {
      // Recalled
      final hardMod = gradeIdx == 1 ? _w[15] : 1.0;
      final easyMod = gradeIdx == 3 ? _w[16] : 1.0;
      newS = card.stability *
          (exp(_w[8]) *
                  (11 - card.difficulty) *
                  pow(card.stability, -_w[9]) *
                  (exp(_w[10] * (1 - r)) - 1) *
                  hardMod *
                  easyMod +
              1);
    }

    final clampedS = newS.clamp(0.1, 365.0);
    final newD = (card.difficulty - _w[5] * (3 - fsrsGrade)).clamp(1.0, 10.0);
    final interval = max(1, clampedS.round());

    return card.copyWith(
      stability: clampedS,
      difficulty: newD,
      retrievability: exp(-interval.toDouble() / clampedS),
      reps: card.reps + 1,
      interval: interval,
      lastReviewDate: Value(DateTime.now()),
      nextReviewDate: DateTime.now().add(Duration(days: interval)),
    );
  }
}
