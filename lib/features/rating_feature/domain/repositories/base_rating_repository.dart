import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/entities/rating.dart';

import '../../../../core/errors/failures.dart';

abstract class BaseRatingRepository {
  Future<Either<Failure, Unit>> addRating({
    required String comment,
    required int rating,
  });

  Future<Either<Failure, Rating>> getRating({
    required String currentPage,
  });
}
