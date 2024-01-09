import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order.dart' as order;
import '../entities/orders_pagenation.dart';

abstract class BaseOrderRepository {
  Future<Either<Failure, order.Order>> checkAvailableOrder();

  Future<Either<Failure, order.Order>> createOrder({
    required String locationId,
    required String notes,
  });

  Future<Either<Failure, OrdersPagenation>> getAllOrders(
      {required String currentPage});

  Future<Either<Failure, order.Order?>> rejectOrder();

  Future<Either<Failure, order.Order?>> assignOrder({
    required int paymentMethod,
    required int quantity,
  });

  Future<Either<Failure, String>> cancelOrder();

  Future<Either<Failure, String>> cancelConfirmOrder();

  Future<Either<Failure, String>> cancelOrderWithReason({
    required String reason,
  });
}
