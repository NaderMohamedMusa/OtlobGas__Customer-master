import 'package:otlobgas_driver/features/notifications_feature/domain/entities/notification_content.dart';

class NotificationContentModel extends NotificationContent {
  const NotificationContentModel({
    required super.id,
    required super.userId,
    required super.message,
    required super.date,
    required super.status,
  });

  factory NotificationContentModel.fromMap(Map<String, dynamic> map) =>
      NotificationContentModel(
        id: map['id'],
        userId: map['user_id'],
        message: map['message'],
        date: map['date'],
        status: map['status'],
      );
}
