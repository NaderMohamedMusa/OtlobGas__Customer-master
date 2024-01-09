import 'package:equatable/equatable.dart';
import 'package:otlobgas_driver/core/consts/enums.dart';
import 'driver.dart';

// ignore: must_be_immutable
class Order extends Equatable {
  int id;
  double customerLat;
  double customerLng;
  double driverLat;
  double driverLng;
  String floorNum;
  String buildingNum;
  double unitPrice;
  double distancePrice;
  int quantity;
  double delivery;
  double tax;
  double totalPrice;
  int paymentMethod;
  String notes;
  String address;
  OrderStatus status;
  Driver driver;
  DateTime createdAt;
  double distance;
  String time;

  Order({
    required this.id,
    required this.customerLat,
    required this.customerLng,
    required this.driverLat,
    required this.driverLng,
    required this.floorNum,
    required this.buildingNum,
    required this.unitPrice,
    required this.distancePrice,
    required this.quantity,
    required this.delivery,
    required this.tax,
    required this.totalPrice,
    required this.paymentMethod,
    required this.notes,
    required this.address,
    required this.status,
    required this.driver,
    required this.createdAt,
    required this.distance,
    required this.time,
  });

  @override
  List<Object?> get props => [
        id,
        customerLat,
        customerLng,
        driverLat,
        driverLng,
        floorNum,
        buildingNum,
        unitPrice,
        distancePrice,
        quantity,
        delivery,
        tax,
        totalPrice,
        paymentMethod,
        notes,
        address,
        status,
        driver,
        createdAt,
        distance,
        time,
      ];
}
