import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/base_rating_repository.dart';

class AddRatingUseCase {
  final BaseRatingRepository baseRatingRepository;

  AddRatingUseCase({required this.baseRatingRepository});

  Future<Either<Failure, Unit>> call({
    required String comment,
    required int rating,
  }) async {
    return await baseRatingRepository.addRating(
      comment: comment,
      rating: rating,
    );
  }
}
