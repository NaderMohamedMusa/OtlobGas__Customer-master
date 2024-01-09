import 'package:otlobgas_driver/features/auth_feature/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.id,
    required super.lat,
    required super.long,
    required super.title,
    super.floorNum,
    super.buildingNum,
    required super.isDefault,
    required super.zoneId,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
        id: map['id'],
        lat: map['lat'],
        long: map['long'],
        title: map['title'],
        floorNum: map['floor_nu'],
        buildingNum: map['building_nu'],
        isDefault: map['default'] == 0 ? false : true,
        zoneId: map['zone_id'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'lat': lat,
        'long': long,
        'title': title,
        'floor_nu': floorNum,
        'building_nu': buildingNum,
        'default': isDefault,
        'zone_id': zoneId,
      };
}
