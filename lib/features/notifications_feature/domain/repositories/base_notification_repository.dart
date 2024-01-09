import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/core/utils/hold_message_with.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';

import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';

abstract class BaseNotificationRepository {
  Future<Either<Failure, Notification>> getAllNotifications({
    required String currentPage,
  });

  Future<Either<Failure, Notification>> getTodayNotifications({
    required String currentPage,
  });

  Future<Either<Failure, Unit>> deleteAllNotifications();
  Future<Either<Failure, Notification>> deleteNotification({
    required int notificationId,
    required bool isTodayNotification,
  });
  Future<Either<Failure, HoldMessageWith<User>>> readNotification();
}
