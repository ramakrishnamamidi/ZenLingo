import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';
import '../../../core/providers/srs_algorithm_provider.dart';
import '../../../core/srs/srs_algorithm.dart';
import '../../../data/database/app_database.dart';

class SrsReviewSession extends AsyncNotifier<List<VocabularyCard>> {
  @override
  Future<List<VocabularyCard>> build() {
    return ref.watch(srsDaoProvider).getDueCards();
  }

  Future<void> gradeCard(VocabularyCard card, SrsGrade grade) async {
    final algo = ref.read(srsAlgorithmProvider);
    final updated = algo.schedule(card, grade);
    await ref.read(srsDaoProvider).updateCard(updated);
    ref.invalidateSelf();
  }
}

final srsReviewSessionProvider =
    AsyncNotifierProvider<SrsReviewSession, List<VocabularyCard>>(
  SrsReviewSession.new,
);
