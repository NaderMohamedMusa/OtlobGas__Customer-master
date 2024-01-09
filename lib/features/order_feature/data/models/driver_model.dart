import '../../domain/entities/driver.dart';

class DriverModel extends Driver {
  const DriverModel({
    required super.name,
    required super.mobile,
    required super.image,
    required super.rate,
    required super.vehicleNumber,
    required super.vehicleType,
  });

  factory DriverModel.fromMap(Map<String, dynamic> map) => DriverModel(
        name: map['name'],
        mobile: map['mobile'],
        image: map['image_for_web'],
        rate: map['avg_rate'],
        vehicleNumber: map['vehicle_number'],
        vehicleType: map['vehicle_type'],
      );
}
