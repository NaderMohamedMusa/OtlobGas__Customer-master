import 'package:equatable/equatable.dart';

import 'rating_content.dart';

class Rating extends Equatable {
  final int currentPage;
  final int lastPage;
  final List<RatingContent> data;

  const Rating({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  @override
  List<Object?> get props => [
        currentPage,
        lastPage,
        data,
      ];
}
