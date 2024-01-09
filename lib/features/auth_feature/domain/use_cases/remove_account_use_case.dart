import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class RemoveAccountUseCase {
  final BaseAuthRepository baseAuthRepository;

  RemoveAccountUseCase({required this.baseAuthRepository});

  Future<Either<Failure, Unit>> call() async {
    return await baseAuthRepository.removeAccount();
  }
}
