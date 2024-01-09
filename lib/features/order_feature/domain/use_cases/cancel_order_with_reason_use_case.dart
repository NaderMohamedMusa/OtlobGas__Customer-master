import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';

class CancelOrderWithReasonUseCase {
  final BaseOrderRepository baseOrderRepository;

  CancelOrderWithReasonUseCase({required this.baseOrderRepository});

  Future<Either<Failure, String>> call({
    required String reason,
  }) async {
    return await baseOrderRepository.cancelOrderWithReason(reason: reason);
  }
}
