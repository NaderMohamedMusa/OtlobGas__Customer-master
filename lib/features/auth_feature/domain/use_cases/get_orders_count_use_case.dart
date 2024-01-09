import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/orders_count.dart';
import '../repositories/base_auth_repository.dart';

class GetOrdersCountUseCase {
  final BaseAuthRepository baseAuthRepository;

  GetOrdersCountUseCase({required this.baseAuthRepository});

  Future<Either<Failure, OrdersCount>> call() async {
    return await baseAuthRepository.getOrdersCount();
  }
}
