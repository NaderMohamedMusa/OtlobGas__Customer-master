import '../../domain/entities/nearest_driver.dart';

class NearestDriverModel extends NearestDriver {
  const NearestDriverModel({
    required super.lat,
    required super.long,
  });

  factory NearestDriverModel.fromMap(Map<String, dynamic> map) =>
      NearestDriverModel(
        lat: map['lat'],
        long: map['long'],
      );
}
