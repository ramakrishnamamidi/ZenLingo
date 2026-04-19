import '../models/chat_message.dart';
import 'llm_service.dart';

class MockLlmService implements LlmService {
  static const _tips = [
    'こんにちは (Konnichiwa) means "Hello" but literally translates to "As for now, it is..." — a remnant of a longer phrase. Japanese greetings are often time-aware: おはよう for morning, こんにちは for midday, こんばんは for evening.',
    'The particle は (wa) marks the topic, while が (ga) marks the subject. "私は学生です" (I am a student) uses は because you are presenting yourself as a topic of conversation — a subtle but important distinction in Japanese grammar.',
    'Japanese has three scripts: hiragana (ひらがな) for native words, katakana (カタカナ) for foreign loan words, and kanji (漢字) for meaning-bearing characters. Mastering all three is the foundation of literacy.',
    'あいうえお — the five vowel sounds of Japanese are pure and consistent, unlike English. Once learned, every hiragana and katakana character is phonetically predictable. This makes Japanese pronunciation far more regular than English.',
    'The word 勉強 (benkyō, study) contains kanji meaning "make an effort" + "strong." In Japanese culture, learning is seen as an act of perseverance — a concept called 根性 (konjō), meaning grit or fighting spirit.',
  ];

  int _tipIndex = 0;

  @override
  bool get isLoaded => true;

  @override
  Stream<String> chat(List<ChatMessage> history, String userInput) async* {
    await Future.delayed(const Duration(milliseconds: 400));
    final tip = _tips[_tipIndex % _tips.length];
    _tipIndex++;
    yield '[Demo mode — download model for full AI]\n\n$tip';
  }
}
