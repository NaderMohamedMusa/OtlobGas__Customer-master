import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/last_week.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_auth_repository.dart';

class GetLastWeekUseCase {
  final BaseAuthRepository baseAuthRepository;

  GetLastWeekUseCase({required this.baseAuthRepository});

  Future<Either<Failure, List<LastWeek>>> call() async {
    return await baseAuthRepository.getLastWeek();
  }
}
