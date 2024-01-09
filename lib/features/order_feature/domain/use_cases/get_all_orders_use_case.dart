import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/orders_pagenation.dart';
import 'package:otlobgas_driver/features/order_feature/domain/repositories/base_order_repository.dart';

import '../../../../core/errors/failures.dart';

class GetAllOrdersUseCase {
  final BaseOrderRepository baseOrderRepository;

  GetAllOrdersUseCase({required this.baseOrderRepository});

  Future<Either<Failure, OrdersPagenation>> call(
      {required String currentPage}) async {
    return await baseOrderRepository.getAllOrders(currentPage: currentPage);
  }
}
