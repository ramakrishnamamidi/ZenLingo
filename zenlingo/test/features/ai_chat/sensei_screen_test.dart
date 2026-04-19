import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/theme/zen_theme.dart';
import 'package:zenlingo/features/ai_chat/models/chat_message.dart';
import 'package:zenlingo/features/ai_chat/providers/chat_provider.dart';
import 'package:zenlingo/features/ai_chat/screens/sensei_screen.dart';
import 'package:zenlingo/features/ai_chat/services/tts_service.dart';

class _FakeTts extends Fake implements TtsService {
  @override
  Future<void> speak(String text) async {}

  @override
  Future<void> stop() async {}

  @override
  bool get isSpeaking => false;
}

void main() {
  testWidgets('SenseiScreen shows empty state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          chatProvider.overrideWith(() => _FakeChatNotifier([])),
          ttsServiceProvider.overrideWithValue(_FakeTts()),
        ],
        child: MaterialApp(
          theme: ZenTheme.dark,
          home: const SenseiScreen(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('AI SENSEI'), findsOneWidget);
    expect(find.text('Ask me about Japanese culture!'), findsOneWidget);
  });

  testWidgets('SenseiScreen renders messages', (tester) async {
    final msgs = [
      ChatMessage(role: 'user', content: 'Hello', timestamp: DateTime.now()),
      ChatMessage(
          role: 'assistant', content: 'こんにちは', timestamp: DateTime.now()),
    ];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          chatProvider.overrideWith(() => _FakeChatNotifier(msgs)),
          ttsServiceProvider.overrideWithValue(_FakeTts()),
        ],
        child: MaterialApp(
          theme: ZenTheme.dark,
          home: const SenseiScreen(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('こんにちは'), findsOneWidget);
  });
}

class _FakeChatNotifier extends ChatNotifier {
  final List<ChatMessage> _messages;
  _FakeChatNotifier(this._messages);

  @override
  Future<List<ChatMessage>> build() async => _messages;
}
