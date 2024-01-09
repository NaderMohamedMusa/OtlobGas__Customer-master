import '../../domain/entities/notification.dart';
import 'notification_content_model.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.currentPage,
    required super.lastPage,
    required super.data,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        currentPage: map['current_page'],
        lastPage: map['last_page'],
        data: List.from(map['data'])
            .map((e) => NotificationContentModel.fromMap(e))
            .toList(),
      );
}
