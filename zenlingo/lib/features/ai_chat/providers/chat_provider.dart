import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/database_provider.dart';
import '../../../data/database/app_database.dart';
import '../models/chat_message.dart';
import '../services/llm_service.dart';
import '../services/mock_llm_service.dart';
import '../services/tts_service.dart';

final llmServiceProvider = Provider<LlmService>((ref) {
  if (AppConfig.aiChatEnabled) {
    throw UnimplementedError('Real LLM not available in this build');
  }
  return MockLlmService();
});

final ttsServiceProvider = Provider<TtsService>((ref) => SystemTtsService());

class ChatNotifier extends AsyncNotifier<List<ChatMessage>> {
  @override
  Future<List<ChatMessage>> build() async {
    final dao = ref.watch(chatDaoProvider);
    final rows = await dao.getRecentMessages(limit: 50);
    return rows
        .map((r) => ChatMessage(
              role: r.role,
              content: r.content,
              timestamp: r.timestamp,
            ))
        .toList();
  }

  Future<void> sendMessage(String userInput) async {
    final dao = ref.read(chatDaoProvider);
    final llm = ref.read(llmServiceProvider);

    final userMsg = ChatMessage(
      role: 'user',
      content: userInput,
      timestamp: DateTime.now(),
    );
    await dao.insertMessage(ChatHistoryCompanion(
      role: Value('user'),
      content: Value(userInput),
      timestamp: Value(userMsg.timestamp),
      languageCode: const Value('ja'),
    ));

    final current = state.value ?? [];
    state = AsyncData([...current, userMsg]);

    final assistantMsg = ChatMessage(
      role: 'assistant',
      content: '',
      timestamp: DateTime.now(),
    );
    state = AsyncData([...current, userMsg, assistantMsg]);

    final buffer = StringBuffer();
    await for (final chunk in llm.chat(current, userInput)) {
      buffer.write(chunk);
      final updated = assistantMsg.copyWith(content: buffer.toString());
      final msgs = state.value ?? [];
      state = AsyncData([...msgs.take(msgs.length - 1), updated]);
    }

    final finalContent = buffer.toString();
    await dao.insertMessage(ChatHistoryCompanion(
      role: const Value('assistant'),
      content: Value(finalContent),
      timestamp: Value(assistantMsg.timestamp),
      languageCode: const Value('ja'),
    ));
  }

  void clearHistory() {
    state = const AsyncData([]);
  }
}

final chatProvider =
    AsyncNotifierProvider<ChatNotifier, List<ChatMessage>>(ChatNotifier.new);
