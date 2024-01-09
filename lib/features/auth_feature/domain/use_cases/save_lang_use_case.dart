import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class SaveLangUseCase {
  final BaseAuthRepository baseAuthRepository;

  SaveLangUseCase({required this.baseAuthRepository});

  Future<Either<Failure, Unit>> call({required String lang}) async {
    return await baseAuthRepository.saveLang(lang: lang);
  }
}
