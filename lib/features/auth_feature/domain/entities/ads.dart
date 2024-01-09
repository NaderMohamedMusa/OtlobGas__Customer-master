import 'package:equatable/equatable.dart';

class Ads extends Equatable {
  final String link;
  final String image;

  const Ads({
    required this.link,
    required this.image,
  });

  @override
  List<Object?> get props => [
        link,
        image,
      ];
}
