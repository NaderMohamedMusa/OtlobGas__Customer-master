import '../../domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.userId,
    required super.message,
    required super.type,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      userId: map['user_id'],
      type: map['type'],
      message: map['message'] ?? '',
    );
  }
}
