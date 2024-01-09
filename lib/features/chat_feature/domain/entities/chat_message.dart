import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final int userId;
  final String message;
  final String type;

  const ChatMessage({
    required this.userId,
    required this.message,
    required this.type,
  });

  @override
  List<Object?> get props => [
        userId,
        message,
        type,
      ];
}
