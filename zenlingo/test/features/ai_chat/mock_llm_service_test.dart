import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/features/ai_chat/models/chat_message.dart';
import 'package:zenlingo/features/ai_chat/services/mock_llm_service.dart';

void main() {
  final service = MockLlmService();

  test('isLoaded is always true', () {
    expect(service.isLoaded, isTrue);
  });

  test('chat returns non-empty stream', () async {
    final chunks = await service
        .chat(const [], 'What does あ mean?')
        .toList();
    expect(chunks, isNotEmpty);
    expect(chunks.join(), isNotEmpty);
  });

  test('chat response mentions Japanese or Haruki', () async {
    final response = await service
        .chat(const [], 'hello')
        .toList()
        .then((c) => c.join());
    expect(
      response.toLowerCase().contains('japanese') ||
          response.contains('Haruki') ||
          response.contains('日本語'),
      isTrue,
    );
  });

  test('chat with history does not throw', () async {
    final history = [
      ChatMessage(role: 'user', content: 'hello', timestamp: DateTime.now()),
      ChatMessage(role: 'assistant', content: 'こんにちは', timestamp: DateTime.now()),
    ];
    final chunks = await service.chat(history, 'thanks').toList();
    expect(chunks, isNotEmpty);
  });
}
