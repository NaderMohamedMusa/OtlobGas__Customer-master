import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/others_feature/domain/repositories/base_others_repository.dart';

import '../../../../core/errors/failures.dart';

class GetPhoneNumberUseCase {
  final BaseOthersRepository baseOthersRepository;

  GetPhoneNumberUseCase({required this.baseOthersRepository});

  Future<Either<Failure, String>> call() {
    return baseOthersRepository.getPhoneNumber();
  }
}
