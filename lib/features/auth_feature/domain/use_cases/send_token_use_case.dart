import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class SendTokenUseCase {
  final BaseAuthRepository baseAuthRepository;

  SendTokenUseCase({required this.baseAuthRepository});

  Future<Either<Failure, String>> call({
    required String email,
  }) async {
    return await baseAuthRepository.sendToken(
      email: email,
    );
  }
}
