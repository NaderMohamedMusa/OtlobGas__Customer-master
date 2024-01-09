import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class GetUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  GetUserUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call() async {
    return await baseAuthRepository.getUser();
  }
}
