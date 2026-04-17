import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/review_sessions.dart';

part 'session_dao.g.dart';

@DriftAccessor(tables: [ReviewSessions])
class SessionDao extends DatabaseAccessor<AppDatabase> with _$SessionDaoMixin {
  SessionDao(super.db);

  Future<int> insertSession(ReviewSessionsCompanion session) {
    return into(reviewSessions).insert(session);
  }

  Future<List<ReviewSession>> getLast365Days() {
    final cutoff = DateTime.now().subtract(const Duration(days: 365));
    return (select(reviewSessions)
          ..where((s) => s.sessionDate.isBiggerOrEqualValue(cutoff))
          ..orderBy([(s) => OrderingTerm(expression: s.sessionDate)]))
        .get();
  }
}
