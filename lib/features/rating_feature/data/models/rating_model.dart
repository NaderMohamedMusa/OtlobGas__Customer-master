import 'package:otlobgas_driver/features/rating_feature/domain/entities/rating.dart';

import 'rating_content_model.dart';

class RatingModel extends Rating {
  const RatingModel({
    required super.currentPage,
    required super.lastPage,
    required super.data,
  });

  factory RatingModel.fromMap(Map<String, dynamic> map) => RatingModel(
        currentPage: map['current_page'],
        lastPage: map['last_page'],
        data: List.from(map['data'])
            .map((e) => RatingContentModel.fromMap(e))
            .toList(),
      );
}
