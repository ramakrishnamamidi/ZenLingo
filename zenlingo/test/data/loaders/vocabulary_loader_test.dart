import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/data/database/daos/srs_dao.dart';
import 'package:zenlingo/data/loaders/vocabulary_loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late SrsDao srsDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory(), seedOnCreate: false);
    srsDao = db.srsDao;
  });

  tearDown(() async {
    await db.close();
  });

  test('parseEntries returns correct count from JSON list', () {
    const jsonStr = '''[
      {"word":"水","reading":"みず","meaning":"water","jlpt_level":5,"tags":["noun"]},
      {"word":"火","reading":"ひ","meaning":"fire","jlpt_level":5,"tags":["noun"]}
    ]''';
    final loader = VocabularyLoader(db);
    final entries = loader.parseEntries(jsonDecode(jsonStr) as List<dynamic>);
    expect(entries.length, 2);
    expect(entries[0].word.value, '水');
    expect(entries[1].reading.value, 'ひ');
  });

  test('insertAll inserts cards into database', () async {
    const jsonStr = '''[
      {"word":"水","reading":"みず","meaning":"water","jlpt_level":5,"tags":["noun"]},
      {"word":"火","reading":"ひ","meaning":"fire","jlpt_level":5,"tags":["noun"]}
    ]''';
    final loader = VocabularyLoader(db);
    final entries = loader.parseEntries(jsonDecode(jsonStr) as List<dynamic>);
    await loader.insertAll(entries);
    final count = await srsDao.countAllCards();
    expect(count, 2);
  });

  test('insertAll is idempotent (no duplicates on second call)', () async {
    const jsonStr = '''[{"word":"水","reading":"みず","meaning":"water","jlpt_level":5,"tags":["noun"]}]''';
    final loader = VocabularyLoader(db);
    final entries = loader.parseEntries(jsonDecode(jsonStr) as List<dynamic>);
    await loader.insertAll(entries);
    await loader.insertAll(entries); // second call
    final count = await srsDao.countAllCards();
    expect(count, 1); // still only 1
  });

  test('parseEntries handles missing optional fields', () {
    const jsonStr = '''[{"word":"水","reading":"みず","meaning":"water","jlpt_level":5}]''';
    final loader = VocabularyLoader(db);
    final entries = loader.parseEntries(jsonDecode(jsonStr) as List<dynamic>);
    expect(entries.length, 1);
    expect(entries[0].exampleSentence.value, isNull);
    expect(entries[0].tags.value, '[]');
  });
}
