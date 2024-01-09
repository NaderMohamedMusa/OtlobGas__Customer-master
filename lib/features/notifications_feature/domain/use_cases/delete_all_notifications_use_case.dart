import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_notification_repository.dart';

class DeleteAllNotificationsUseCase {
  final BaseNotificationRepository baseNotificationRepository;

  DeleteAllNotificationsUseCase({required this.baseNotificationRepository});

  Future<Either<Failure, Unit>> call() async {
    return await baseNotificationRepository.deleteAllNotifications();
  }
}
