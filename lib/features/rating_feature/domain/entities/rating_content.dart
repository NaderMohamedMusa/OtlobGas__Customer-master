import 'package:equatable/equatable.dart';

class RatingContent extends Equatable {
  final int rating;
  final String comment;
  final DateTime createdAt;

  const RatingContent({
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        rating,
        comment,
        createdAt,
      ];
}
