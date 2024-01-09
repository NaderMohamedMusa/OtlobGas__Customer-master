import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/rating_feature/domain/entities/rating.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_rating_repository.dart';

class GetRatingUseCase {
  final BaseRatingRepository baseRatingRepository;

  GetRatingUseCase({required this.baseRatingRepository});

  Future<Either<Failure, Rating>> call({
    required String currentPage,
  }) async {
    return await baseRatingRepository.getRating(currentPage: currentPage);
  }
}
