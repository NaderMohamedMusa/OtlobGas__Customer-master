import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';
import '../repositories/base_notification_repository.dart';

class DeleteNotificationUseCase {
  final BaseNotificationRepository baseNotificationRepository;

  DeleteNotificationUseCase({required this.baseNotificationRepository});

  Future<Either<Failure, Notification>> call({
    required int notificationId,
    required bool isTodayNotification,
  }) async {
    return await baseNotificationRepository.deleteNotification(
      notificationId: notificationId,
      isTodayNotification: isTodayNotification,
    );
  }
}
