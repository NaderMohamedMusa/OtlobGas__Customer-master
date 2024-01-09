import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/core/utils/hold_message_with.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_notification_repository.dart';

class ReadAllNotificationsUseCase {
  final BaseNotificationRepository baseNotificationRepository;

  ReadAllNotificationsUseCase({required this.baseNotificationRepository});

  Future<Either<Failure, HoldMessageWith<User>>> call() async {
    return await baseNotificationRepository.readNotification();
  }
}
