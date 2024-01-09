import 'package:otlobgas_driver/features/rating_feature/domain/entities/rating_content.dart';

class RatingContentModel extends RatingContent {
  const RatingContentModel({
    required super.rating,
    required super.comment,
    required super.createdAt,
  });

  factory RatingContentModel.fromMap(Map<String, dynamic> map) =>
      RatingContentModel(
        rating: map['rating'],
        comment: map['comment'],
        createdAt: DateTime.parse(map['created_at']),
      );
}
