import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';

class CancelOrderUseCase {
  final BaseOrderRepository baseOrderRepository;

  CancelOrderUseCase({required this.baseOrderRepository});

  Future<Either<Failure, String>> call() async {
    return await baseOrderRepository.cancelOrder();
  }
}
