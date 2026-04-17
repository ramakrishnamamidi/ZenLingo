import 'package:drift/drift.dart';

class VocabularyCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 1, max: 50)();
  TextColumn get reading => text()();
  TextColumn get meaning => text()();
  TextColumn get exampleSentence => text().nullable()();
  IntColumn get jlptLevel => integer().withDefault(const Constant(5))();
  TextColumn get languageCode => text().withDefault(const Constant('ja'))();

  // FSRS fields
  RealColumn get stability => real().withDefault(const Constant(1.0))();
  RealColumn get difficulty => real().withDefault(const Constant(5.0))();
  RealColumn get retrievability => real().withDefault(const Constant(1.0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();

  // SM-2 fallback fields
  RealColumn get easinessFactor => real().withDefault(const Constant(2.5))();
  IntColumn get interval => integer().withDefault(const Constant(1))();

  DateTimeColumn get nextReviewDate =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastReviewDate => dateTime().nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))();
}
