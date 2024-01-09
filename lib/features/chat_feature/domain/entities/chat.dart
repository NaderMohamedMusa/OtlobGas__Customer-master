import 'package:equatable/equatable.dart';

import 'chat_message.dart';

class Chat extends Equatable {
  final int orderId;
  final List<ChatMessage> messages;

  const Chat({
    required this.orderId,
    required this.messages,
  });

  @override
  List<Object?> get props => [
        orderId,
        messages,
      ];
}
