import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/vocabulary_cards.dart';

part 'srs_dao.g.dart';

@DriftAccessor(tables: [VocabularyCards])
class SrsDao extends DatabaseAccessor<AppDatabase> with _$SrsDaoMixin {
  SrsDao(super.db);

  Stream<List<VocabularyCard>> watchDueCards() {
    return (select(vocabularyCards)
          ..where((c) => c.nextReviewDate.isSmallerOrEqualValue(DateTime.now()))
          ..orderBy([(c) => OrderingTerm(expression: c.nextReviewDate)])
          ..limit(50))
        .watch();
  }

  Future<List<VocabularyCard>> getDueCards() {
    return (select(vocabularyCards)
          ..where((c) => c.nextReviewDate.isSmallerOrEqualValue(DateTime.now()))
          ..orderBy([(c) => OrderingTerm(expression: c.nextReviewDate)])
          ..limit(50))
        .get();
  }

  Future<void> updateCard(VocabularyCard card) {
    return (update(vocabularyCards)..where((c) => c.id.equals(card.id))).write(
      VocabularyCardsCompanion(
        stability: Value(card.stability),
        difficulty: Value(card.difficulty),
        retrievability: Value(card.retrievability),
        reps: Value(card.reps),
        interval: Value(card.interval),
        easinessFactor: Value(card.easinessFactor),
        nextReviewDate: Value(card.nextReviewDate),
        lastReviewDate: Value(card.lastReviewDate),
      ),
    );
  }

  Future<int> insertCard(VocabularyCardsCompanion card) {
    return into(vocabularyCards).insert(card);
  }

  Future<int> countAllCards() async {
    final count = vocabularyCards.id.count();
    final query = selectOnly(vocabularyCards)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<int> countMasteredCards() async {
    // A card is mastered when retrievability > 0.85
    final count = vocabularyCards.id.count();
    final query = selectOnly(vocabularyCards)
      ..addColumns([count])
      ..where(vocabularyCards.retrievability.isBiggerThanValue(0.85));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
