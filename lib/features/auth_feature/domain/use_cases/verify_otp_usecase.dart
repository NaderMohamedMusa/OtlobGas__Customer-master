import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';

import '../repositories/base_auth_repository.dart';

class VerifyOtpUseCase {
  final BaseAuthRepository baseAuthRepository;

  VerifyOtpUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String code,
    required String phone,
  }) {
    return baseAuthRepository.verifyOtpCode(
      code: code,
      phone: phone,
    );
  }
}
