import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth_feature/domain/entities/user.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart'
    as order;

import '../../../chat_feature/domain/entities/chat.dart';

abstract class BasePusherRepository {
  Stream<order.Order> listenToOrder();

  Stream<User> listenToUser();

  Stream<Chat> listenToChat();

  Future<Either<Failure, Unit>> initPusher({required int driverId});

  Future<Either<Failure, Unit>> disconnectPusher();

  Future<Either<Failure, Unit>> subscribeToChat({required int orderId});

  Future<Either<Failure, Unit>> subscribeToOrder({required int driverId});
}
