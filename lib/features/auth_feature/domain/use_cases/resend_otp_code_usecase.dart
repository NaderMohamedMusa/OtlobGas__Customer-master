import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';

import '../repositories/base_auth_repository.dart';

class ResendOtpCodeUseCase {
  final BaseAuthRepository baseAuthRepository;

  ResendOtpCodeUseCase({required this.baseAuthRepository});

  Future<Either<Failure, Unit>> call({
    required String phone,
  }) {
    return baseAuthRepository.resendOtpCode(
      phone: phone,
    );
  }
}
