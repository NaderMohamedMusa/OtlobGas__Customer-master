import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/core/utils/hold_message_with.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/repositories/base_auth_repository.dart';

import '../../../../core/errors/failures.dart';

class ChargeBalanceUseCase {
  final BaseAuthRepository baseAuthRepository;

  ChargeBalanceUseCase({required this.baseAuthRepository});

  Future<Either<Failure, HoldMessageWith<User>>> call(
      {required String cardNumber}) async {
    return await baseAuthRepository.chargeBalance(cardNumber: cardNumber);
  }
}
