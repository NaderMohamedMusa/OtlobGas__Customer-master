import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart'
    as order;
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';

class CheckAvailableOrderUseCase {
  final BaseOrderRepository baseOrderRepository;

  CheckAvailableOrderUseCase({required this.baseOrderRepository});

  Future<Either<Failure, order.Order>> call() async {
    return await baseOrderRepository.checkAvailableOrder();
  }
}
