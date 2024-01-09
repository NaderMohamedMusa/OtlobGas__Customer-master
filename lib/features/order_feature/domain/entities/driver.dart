import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final String name;
  final String mobile;
  final String image;
  final String rate;
  final String? vehicleNumber;
  final String? vehicleType;

  const Driver({
    required this.name,
    required this.mobile,
    required this.image,
    required this.rate,
    required this.vehicleNumber,
    required this.vehicleType,
  });

  @override
  List<Object?> get props => [
        name,
        mobile,
        image,
        rate,
        vehicleNumber,
        vehicleType,
      ];
}
