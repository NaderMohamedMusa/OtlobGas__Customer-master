import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class ResetPasswordUseCase {
  final BaseAuthRepository baseAuthRepository;

  ResetPasswordUseCase({required this.baseAuthRepository});

  Future<Either<Failure, String>> call({
    required String email,
    required String token,
    required String pass,
    required String conPass,
  }) async {
    return await baseAuthRepository.resetPassword(
      email: email,
      token: token,
      pass: pass,
      conPass: conPass,
    );
  }
}
