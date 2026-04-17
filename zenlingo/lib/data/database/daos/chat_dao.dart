import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/chat_history.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [ChatHistory])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  Future<int> insertMessage(ChatHistoryCompanion message) {
    return into(chatHistory).insert(message);
  }

  Future<List<ChatHistoryData>> getRecentMessages({int limit = 20}) {
    return (select(chatHistory)
          ..orderBy([(m) => OrderingTerm.desc(m.timestamp)])
          ..limit(limit))
        .get();
  }
}
