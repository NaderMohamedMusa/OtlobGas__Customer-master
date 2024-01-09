import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/repositories/base_auth_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/hold_message_with.dart';

class ChangeUserActivityUseCase {
  final BaseAuthRepository baseAuthRepository;

  ChangeUserActivityUseCase({required this.baseAuthRepository});

  Future<Either<Failure, HoldMessageWith<User>>> call({
    required String lat,
    required String long,
  }) async {
    return await baseAuthRepository.changeUserActivity(
      lat: lat,
      long: long,
    );
  }
}
