import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/vocabulary_cards.dart';
import 'tables/review_sessions.dart';
import 'tables/stroke_templates.dart';
import 'tables/chat_history.dart';
import 'daos/srs_dao.dart';
import 'daos/session_dao.dart';
import 'daos/stroke_dao.dart';
import 'daos/chat_dao.dart';
import '../loaders/vocabulary_loader.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [VocabularyCards, ReviewSessions, StrokeTemplates, ChatHistory],
  daos: [SrsDao, SessionDao, StrokeDao, ChatDao],
)
class AppDatabase extends _$AppDatabase {
  final bool seedOnCreate;

  AppDatabase(super.e, {this.seedOnCreate = true});

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      // All new columns must be nullable to avoid breaking existing records
    },
    beforeOpen: (details) async {
      if (details.wasCreated && seedOnCreate) {
        await VocabularyLoader(this).seedFromAssets();
      }
    },
  );
}

QueryExecutor openConnection() {
  if (kIsWeb) {
    throw UnimplementedError('Web support added in Phase 5');
  }
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'zenlingo.db'));
    return NativeDatabase(file);
  });
}
