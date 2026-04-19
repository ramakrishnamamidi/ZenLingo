import '../models/chat_message.dart';

abstract class LlmService {
  /// Returns a stream of token chunks. Concatenate to get full response.
  Stream<String> chat(List<ChatMessage> history, String userInput);

  bool get isLoaded;
}
