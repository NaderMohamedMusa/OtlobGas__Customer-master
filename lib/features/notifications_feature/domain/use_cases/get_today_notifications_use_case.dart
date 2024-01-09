import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';
import '../repositories/base_notification_repository.dart';

class GetTodayNotificationsUseCase {
  final BaseNotificationRepository baseNotificationRepository;

  GetTodayNotificationsUseCase({required this.baseNotificationRepository});

  Future<Either<Failure, Notification>> call({
    required String currentPage,
  }) async {
    return await baseNotificationRepository.getTodayNotifications(
        currentPage: currentPage);
  }
}
