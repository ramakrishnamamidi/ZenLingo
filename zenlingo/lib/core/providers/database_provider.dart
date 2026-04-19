import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/database/daos/chat_dao.dart';
import '../../data/database/daos/session_dao.dart';
import '../../data/database/daos/srs_dao.dart';
import '../../data/database/daos/stroke_dao.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(openConnection());
  ref.onDispose(db.close);
  return db;
});

final srsDaoProvider = Provider<SrsDao>((ref) {
  return ref.watch(databaseProvider).srsDao;
});

final sessionDaoProvider = Provider<SessionDao>((ref) {
  return ref.watch(databaseProvider).sessionDao;
});

final strokeDaoProvider = Provider<StrokeDao>((ref) {
  return ref.watch(databaseProvider).strokeDao;
});

final chatDaoProvider = Provider<ChatDao>((ref) {
  return ref.watch(databaseProvider).chatDao;
});
