import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';

import '../repositories/base_pusher_repository.dart';

class ListenToUserUseCase {
  final BasePusherRepository basePusherRepository;

  ListenToUserUseCase({
    required this.basePusherRepository,
  });

  Stream<User> call() {
    return basePusherRepository.listenToUser();
  }
}
