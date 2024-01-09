import 'package:equatable/equatable.dart';

class NearestDriver extends Equatable {
  final String lat;
  final String long;

  const NearestDriver({
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [
        lat,
        long,
      ];
}
