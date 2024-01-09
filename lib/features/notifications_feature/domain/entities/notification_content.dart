import 'package:equatable/equatable.dart';

class NotificationContent extends Equatable {
  final int id;
  final int userId;
  final String message;
  final String date;
  final int status;

  const NotificationContent({
    required this.id,
    required this.userId,
    required this.message,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        message,
        date,
        status,
      ];
}
