import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat.dart';
import '../repositories/base_chat_repository.dart';

class GetChatUseCase {
  final BaseChatRepository baseChatRepository;

  GetChatUseCase({
    required this.baseChatRepository,
  });

  Future<Either<Failure, Chat>> call() async {
    return await baseChatRepository.getChat();
  }
}
