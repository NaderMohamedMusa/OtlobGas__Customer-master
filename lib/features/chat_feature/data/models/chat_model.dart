import 'package:otlobgas_driver/features/chat_feature/domain/entities/chat.dart';

import 'chat_message_model.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.orderId,
    required super.messages,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) => ChatModel(
        orderId: map['order_id'],
        messages: map['messages'] != null
            ? List<ChatMessageModel>.from(
                (map['messages'] as List<dynamic>).map<ChatMessageModel?>(
                  (x) => ChatMessageModel.fromMap(x as Map<String, dynamic>),
                ),
              )
            : [],
      );
}
