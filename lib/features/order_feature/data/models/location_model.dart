import 'package:otlobgas_driver/features/order_feature/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.lat,
    required super.long,
  });

  factory LocationModel.fromMap(String lat, String long) => LocationModel(
        lat: lat,
        long: long,
      );
}
