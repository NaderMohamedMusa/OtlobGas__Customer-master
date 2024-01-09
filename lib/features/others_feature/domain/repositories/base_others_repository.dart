import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/others_feature/domain/entities/nearest_driver.dart';

import '../../../../core/errors/failures.dart';

abstract class BaseOthersRepository {
  Future<Either<Failure, List<NearestDriver>>> getNearestDrivers({
    required String lat,
    required String long,
  });

  Future<Either<Failure, String>> getTerms();

  Future<Either<Failure, String>> getAboutApp();

  Future<Either<Failure, String>> getPrivacy();

  Future<Either<Failure, String>> getPhoneNumber();

  Future<Either<Failure, String>> contactUs({
    required String title,
    required String message,
    required String file,
  });
}
