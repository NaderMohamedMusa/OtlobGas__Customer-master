import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/repositories/base_auth_repository.dart';

import '../../../../core/errors/failures.dart';

class UpdateUserLocationUseCase {
  final BaseAuthRepository baseAuthRepository;

  UpdateUserLocationUseCase({required this.baseAuthRepository});

  Future<Either<Failure, Unit>> call({
    required String lat,
    required String long,
  }) async {
    return await baseAuthRepository.updateUserLocation(
      lat: lat,
      long: long,
    );
  }
}
