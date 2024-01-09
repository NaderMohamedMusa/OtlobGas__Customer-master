import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order.dart' as order;

class RejectOrderUseCase {
  final BaseOrderRepository baseOrderRepository;

  RejectOrderUseCase({required this.baseOrderRepository});

  Future<Either<Failure, order.Order?>> call() async {
    return await baseOrderRepository.rejectOrder();
  }
}
