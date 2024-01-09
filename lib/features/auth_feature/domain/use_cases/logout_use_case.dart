import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class LogoutUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  LogoutUserUseCase({required this.baseAuthRepository});

  Future<Either<Failure, Unit>> call() async {
    return await baseAuthRepository.logOut();
  }
}
