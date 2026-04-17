import 'package:drift/drift.dart';

class StrokeTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get character => text()();
  TextColumn get scriptType => text()(); // hiragana, katakana, kanji
  TextColumn get strokesJson => text()(); // JSON serialized strokes array
  IntColumn get strokeCount => integer()();
}
