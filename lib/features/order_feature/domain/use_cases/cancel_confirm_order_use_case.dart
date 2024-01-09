import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';

class CancelConfirmOrderUseCase {
  final BaseOrderRepository baseOrderRepository;

  CancelConfirmOrderUseCase({required this.baseOrderRepository});

  Future<Either<Failure, String>> call() async {
    return await baseOrderRepository.cancelConfirmOrder();
  }
}
