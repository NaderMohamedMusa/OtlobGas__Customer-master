import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class VerifyAccountUseCase {
  final BaseAuthRepository baseAuthRepository;

  VerifyAccountUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call() {
    return baseAuthRepository.verifyAccount();
  }
}
