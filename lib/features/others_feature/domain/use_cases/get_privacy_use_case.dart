import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/others_feature/domain/repositories/base_others_repository.dart';

import '../../../../core/errors/failures.dart';

class GetPrivacyUseCase {
  final BaseOthersRepository baseOthersRepository;

  GetPrivacyUseCase({required this.baseOthersRepository});

  Future<Either<Failure, String>> call() {
    return baseOthersRepository.getPrivacy();
  }
}
