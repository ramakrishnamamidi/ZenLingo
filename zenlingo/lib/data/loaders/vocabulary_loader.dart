import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../database/app_database.dart';

class VocabularyLoader {
  static const Map<String, String> _assetPaths = {
    'ja': 'assets/data/jp_n5.json',
  };

  final AppDatabase _db;

  VocabularyLoader(this._db);

  Future<void> seedFromAssets() async {
    for (final entry in _assetPaths.entries) {
      final jsonStr = await rootBundle.loadString(entry.value);
      final rawList = jsonDecode(jsonStr) as List<dynamic>;
      final entries = parseEntries(rawList);
      await insertAll(entries);
    }
  }

  List<VocabularyCardsCompanion> parseEntries(List<dynamic> rawList) {
    return rawList.map((e) {
      final map = e as Map<String, dynamic>;
      final tags = (map['tags'] as List<dynamic>?) ?? [];
      return VocabularyCardsCompanion(
        word: Value(map['word'] as String),
        reading: Value(map['reading'] as String),
        meaning: Value(map['meaning'] as String),
        exampleSentence: Value(map['example_sentence'] as String?),
        jlptLevel: Value(map['jlpt_level'] as int? ?? 5),
        languageCode: const Value('ja'),
        tags: Value(jsonEncode(tags)),
      );
    }).toList();
  }

  Future<void> insertAll(List<VocabularyCardsCompanion> entries) async {
    await _db.batch((batch) {
      batch.insertAll(
        _db.vocabularyCards,
        entries,
        mode: InsertMode.insertOrIgnore,
      );
    });
  }
}
