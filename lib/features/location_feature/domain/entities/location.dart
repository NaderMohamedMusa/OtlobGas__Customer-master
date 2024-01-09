import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final String lat;
  final String long;
  final String title;
  final String? floorNum;
  final String? buildingNum;

  const Location({
    required this.id,
    required this.lat,
    required this.long,
    required this.title,
    this.floorNum,
    this.buildingNum,
  });

  @override
  List<Object?> get props => [
        id,
        lat,
        long,
        title,
        floorNum,
        buildingNum,
      ];
}
