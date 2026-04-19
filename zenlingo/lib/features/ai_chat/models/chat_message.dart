class ChatMessage {
  final String role; // 'user' | 'assistant'
  final String content;
  final DateTime timestamp;

  const ChatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  ChatMessage copyWith({String? content}) => ChatMessage(
        role: role,
        content: content ?? this.content,
        timestamp: timestamp,
      );
}
