import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order.dart' as order;

class AssignOrderUseCase {
  final BaseOrderRepository baseOrderRepository;

  AssignOrderUseCase({required this.baseOrderRepository});

  Future<Either<Failure, order.Order?>> call({
    required int paymentMethod,
    required int quantity,
  }) async {
    return await baseOrderRepository.assignOrder(
      paymentMethod: paymentMethod,
      quantity: quantity,
    );
  }
}
