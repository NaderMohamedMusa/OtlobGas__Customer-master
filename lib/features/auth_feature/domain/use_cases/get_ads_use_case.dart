import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ads.dart';
import '../repositories/base_auth_repository.dart';

class GetAdsUseCase {
  final BaseAuthRepository baseAuthRepository;

  GetAdsUseCase({required this.baseAuthRepository});

  Future<Either<Failure, List<Ads>>> call() async {
    return await baseAuthRepository.getAds();
  }
}
