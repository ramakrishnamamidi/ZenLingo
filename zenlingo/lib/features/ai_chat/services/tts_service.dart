import 'package:flutter_tts/flutter_tts.dart';

abstract class TtsService {
  Future<void> speak(String text);
  Future<void> stop();
  bool get isSpeaking;
}

class SystemTtsService implements TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _speaking = false;

  SystemTtsService() {
    _tts.setLanguage('ja-JP');
    _tts.setSpeechRate(0.5);
    _tts.setStartHandler(() => _speaking = true);
    _tts.setCompletionHandler(() => _speaking = false);
    _tts.setErrorHandler((_) => _speaking = false);
  }

  @override
  Future<void> speak(String text) async {
    _speaking = true;
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
    _speaking = false;
  }

  @override
  bool get isSpeaking => _speaking;
}
