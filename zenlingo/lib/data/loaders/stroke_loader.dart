import 'dart:convert';

import 'package:flutter/services.dart';

import '../database/app_database.dart';

class StrokeLoader {
  final AppDatabase _db;
  StrokeLoader(this._db);

  static const _hiraganaAssets = [
    'assets/strokes/hiragana/a.json',
    'assets/strokes/hiragana/i.json',
    'assets/strokes/hiragana/u.json',
    'assets/strokes/hiragana/e.json',
    'assets/strokes/hiragana/o.json',
  ];

  Future<void> seedFromAssets() async {
    for (final path in _hiraganaAssets) {
      try {
        final jsonStr = await rootBundle.loadString(path);
        final data = jsonDecode(jsonStr) as Map<String, dynamic>;
        final char = data['char'] as String;
        final strokes = data['strokes'] as List<dynamic>;
        await _db.strokeDao.insertTemplate(
          StrokeTemplatesCompanion.insert(
            character: char,
            scriptType: 'hiragana',
            strokesJson: jsonEncode(strokes),
            strokeCount: strokes.length,
          ),
        );
      } catch (_) {
        // skip missing or malformed assets
      }
    }
  }
}
