import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart'
    as order;
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';

class CreateOrderUseCase {
  final BaseOrderRepository baseOrderRepository;

  CreateOrderUseCase({required this.baseOrderRepository});

  Future<Either<Failure, order.Order>> call({
    required String locationId,
    required String notes,
  }) async {
    return await baseOrderRepository.createOrder(
      locationId: locationId,
      notes: notes,
    );
  }
}
