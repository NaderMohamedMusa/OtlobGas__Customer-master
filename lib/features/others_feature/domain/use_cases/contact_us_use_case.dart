import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/others_feature/domain/repositories/base_others_repository.dart';

import '../../../../core/errors/failures.dart';

class ContactUsUseCase {
  final BaseOthersRepository baseOthersRepository;

  ContactUsUseCase({required this.baseOthersRepository});

  Future<Either<Failure, String>> call({
    required String title,
    required String message,
    required String file,
  }) {
    return baseOthersRepository.contactUs(
      title: title,
      message: message,
      file: file,
    );
  }
}
