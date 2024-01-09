import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat.dart';

abstract class BaseChatRepository {
  Stream<Chat> listenToChat();

  Future<Either<Failure, Unit>> initPusherChat({required int orderId});

  Future<Either<Failure, Unit>> disconnectPusherChat();

  Future<Either<Failure, Chat>> sendMessage({
    required String message,
  });

  Future<Either<Failure, Chat>> getChat();
}
