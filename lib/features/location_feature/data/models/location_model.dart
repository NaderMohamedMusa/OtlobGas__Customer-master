
import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.id,
    required super.lat,
    required super.long,
    required super.title,
    super.floorNum,
    super.buildingNum,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
        id: map['id'],
        lat: map['lat'],
        long: map['long'],
        title: map['title'],
        floorNum: map['floor_num'],
        buildingNum: map['building_num'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'lat': lat,
        'long': long,
        'title': title,
        'floor_num': floorNum,
        'building_num': buildingNum,
      };
}