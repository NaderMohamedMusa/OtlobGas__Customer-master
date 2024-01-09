import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/nearest_driver.dart';
import '../repositories/base_others_repository.dart';

class GetNearestDriversUseCase {
  final BaseOthersRepository baseOthersRepository;

  GetNearestDriversUseCase({required this.baseOthersRepository});

  Future<Either<Failure, List<NearestDriver>>> call({
    required String lat,
    required String long,
  }) {
    return baseOthersRepository.getNearestDrivers(lat: lat, long: long);
  }
}
