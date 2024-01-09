import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class LoginUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  LoginUserUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String mobile,
    required String password,
  }) async {
    return await baseAuthRepository.logIn(
      mobile: mobile,
      password: password,
    );
  }
}
