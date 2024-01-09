import 'package:equatable/equatable.dart';

import 'notification_content.dart';

class Notification extends Equatable {
  final int currentPage;
  final int lastPage;
  final List<NotificationContent> data;

  const Notification({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  @override
  List<Object?> get props => [
        currentPage,
        lastPage,
        data,
      ];
}