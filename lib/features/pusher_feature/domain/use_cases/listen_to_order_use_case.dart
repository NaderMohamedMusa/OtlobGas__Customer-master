import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart';

import '../repositories/base_pusher_repository.dart';

class ListenToOrderUseCase {
  final BasePusherRepository basePusherRepository;

  ListenToOrderUseCase({
    required this.basePusherRepository,
  });

  Stream<Order> call() {
    return basePusherRepository.listenToOrder();
  }
}
