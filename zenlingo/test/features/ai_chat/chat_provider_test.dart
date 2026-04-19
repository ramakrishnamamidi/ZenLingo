import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/data/database/daos/chat_dao.dart';
import 'package:zenlingo/features/ai_chat/providers/chat_provider.dart';
import 'package:zenlingo/features/ai_chat/services/mock_llm_service.dart';
import 'package:zenlingo/core/providers/database_provider.dart';

/// Returns a real in-memory ChatDao — no file I/O, no DB schema mocking.
ChatDao makeFakeChatDao() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  final db = AppDatabase(NativeDatabase.memory(), seedOnCreate: false);
  return db.chatDao;
}

void main() {
  group('chatProvider', () {
    test('initial state is empty list when dao returns empty', () async {
      final container = ProviderContainer(overrides: [
        chatDaoProvider.overrideWithValue(makeFakeChatDao()),
        llmServiceProvider.overrideWithValue(MockLlmService()),
      ]);
      addTearDown(container.dispose);

      final messages = await container.read(chatProvider.future);
      expect(messages, isEmpty);
    });

    test('sendMessage adds user message to state', () async {
      final container = ProviderContainer(overrides: [
        chatDaoProvider.overrideWithValue(makeFakeChatDao()),
        llmServiceProvider.overrideWithValue(MockLlmService()),
      ]);
      addTearDown(container.dispose);

      // Ensure initial build completes.
      await container.read(chatProvider.future);

      await container.read(chatProvider.notifier).sendMessage('Hello');

      final messages = await container.read(chatProvider.future);
      expect(messages.any((m) => m.role == 'user' && m.content == 'Hello'),
          isTrue);
    });

    test('sendMessage adds assistant reply to state', () async {
      final container = ProviderContainer(overrides: [
        chatDaoProvider.overrideWithValue(makeFakeChatDao()),
        llmServiceProvider.overrideWithValue(MockLlmService()),
      ]);
      addTearDown(container.dispose);

      await container.read(chatProvider.future);
      await container.read(chatProvider.notifier).sendMessage('Hello');

      final messages = await container.read(chatProvider.future);
      final assistant = messages.where((m) => m.role == 'assistant').toList();
      expect(assistant, isNotEmpty);
      expect(assistant.last.content, isNotEmpty);
    });

    test('clearHistory resets to empty list', () async {
      final container = ProviderContainer(overrides: [
        chatDaoProvider.overrideWithValue(makeFakeChatDao()),
        llmServiceProvider.overrideWithValue(MockLlmService()),
      ]);
      addTearDown(container.dispose);

      await container.read(chatProvider.future);
      await container.read(chatProvider.notifier).sendMessage('Hello');

      container.read(chatProvider.notifier).clearHistory();

      final messages = await container.read(chatProvider.future);
      expect(messages, isEmpty);
    });
  });
}
