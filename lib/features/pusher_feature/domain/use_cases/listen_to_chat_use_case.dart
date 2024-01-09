import 'package:otlobgas_driver/features/chat_feature/domain/entities/chat.dart';

import '../repositories/base_pusher_repository.dart';

class ListenToChatUseCase {
  final BasePusherRepository basePusherRepository;

  ListenToChatUseCase({
    required this.basePusherRepository,
  });

  Stream<Chat> call() {
    return basePusherRepository.listenToChat();
  }
}
