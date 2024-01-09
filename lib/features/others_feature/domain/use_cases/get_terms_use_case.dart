import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_others_repository.dart';

class GetTermsUseCase {
  final BaseOthersRepository baseOthersRepository;

  GetTermsUseCase({required this.baseOthersRepository});

  Future<Either<Failure, String>> call() {
    return baseOthersRepository.getTerms();
  }
}
