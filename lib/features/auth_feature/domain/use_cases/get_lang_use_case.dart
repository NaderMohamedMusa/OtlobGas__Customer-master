import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class GetLangUseCase {
  final BaseAuthRepository baseAuthRepository;

  GetLangUseCase({required this.baseAuthRepository});

  Future<Either<Failure, String>> call() async {
    return await baseAuthRepository.getLang();
  }
}
