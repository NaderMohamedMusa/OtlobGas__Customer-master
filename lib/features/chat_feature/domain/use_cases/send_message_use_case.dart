import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat.dart';
import '../repositories/base_chat_repository.dart';

class SendMessageUseCase {
  final BaseChatRepository baseChatRepository;

  SendMessageUseCase({
    required this.baseChatRepository,
  });

  Future<Either<Failure, Chat>> call({
    required String message,
  }) async {
    return await baseChatRepository.sendMessage(
      message: message,
    );
  }
}
