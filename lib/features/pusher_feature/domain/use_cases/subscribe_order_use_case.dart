import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_pusher_repository.dart';

class SubscribeOrderUseCase {
  final BasePusherRepository basePusherRepository;

  SubscribeOrderUseCase({
    required this.basePusherRepository,
  });

  Future<Either<Failure, Unit>> call({required int driverId}) async {
    return await basePusherRepository.subscribeToOrder(driverId: driverId);
  }
}
