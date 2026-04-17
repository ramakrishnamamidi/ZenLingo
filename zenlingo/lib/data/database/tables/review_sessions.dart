import 'package:drift/drift.dart';

class ReviewSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get sessionDate => dateTime()();
  IntColumn get cardsReviewed => integer()();
  IntColumn get correctCount => integer()();
  IntColumn get aiConversationSeconds =>
      integer().withDefault(const Constant(0))();
  IntColumn get writingPracticeCount =>
      integer().withDefault(const Constant(0))();
  TextColumn get languageCode =>
      text().withDefault(const Constant('ja'))();
}
