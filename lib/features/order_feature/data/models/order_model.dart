import 'package:otlobgas_driver/core/consts/enums.dart';
import 'package:otlobgas_driver/features/order_feature/data/models/driver_model.dart';

import '../../domain/entities/order.dart';

// ignore: must_be_immutable
class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.customerLat,
    required super.customerLng,
    required super.driverLat,
    required super.driverLng,
    required super.floorNum,
    required super.buildingNum,
    required super.unitPrice,
    required super.distancePrice,
    required super.quantity,
    required super.delivery,
    required super.tax,
    required super.totalPrice,
    required super.paymentMethod,
    required super.notes,
    required super.address,
    required super.status,
    required super.driver,
    required super.createdAt,
    required super.distance,
    required super.time,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
        id: map['id'],
        customerLat: double.tryParse(map['customer_lat'].toString()) ?? 0,
        customerLng: double.tryParse(map['customer_long'].toString()) ?? 0,
        driverLat: double.tryParse(map['driver_lat'].toString()) ?? 0,
        driverLng: double.tryParse(map['driver_long'].toString()) ?? 0,
        floorNum: map['floor_num'] ?? '',
        buildingNum: map['building_num'] ?? '',
        unitPrice: double.tryParse(map['unit_price'].toString()) ?? 0,
        distancePrice: double.tryParse(map['distance_price'].toString()) ?? 0,
        quantity: int.tryParse(map['quantity'].toString()) ?? 1,
        delivery: double.tryParse(map['delivery'].toString()) ?? 0,
        tax: double.tryParse(map['tax_percent'].toString()) ?? 0,
        totalPrice: double.tryParse(map['total_price'].toString()) ?? 0,
        paymentMethod: int.tryParse(map['payment_method'].toString()) ?? 0,
        notes: map['notes'] ?? '',
        address: map['address'],
        status: checkOrderStatus(map['status']),
        driver: DriverModel.fromMap(map['driver']),
        createdAt: DateTime.parse(map['created_at']),
        distance: double.tryParse(map['distance'].toString()) ?? 0,
        time: map['time'],
      );

  static OrderStatus checkOrderStatus(String status) {
    switch (status) {
      case 'create':
        return OrderStatus.create;
      case 'not_driver_found':
        return OrderStatus.noDriverFound;

      case 'delivered':
        return OrderStatus.delivered;

      case 'send_to_driver':
        return OrderStatus.sendToDriver;

      case 'accept_driver':
        return OrderStatus.acceptDriver;

      case 'cancel_by_customer':
        return OrderStatus.cancelByCustomer;

      case 'cancel_by_customer_because_of':
        return OrderStatus.cancelByCustomerBecauseOf;

      case 'rejected':
        return OrderStatus.rejected;

      case 'cancel_by_driver':
        return OrderStatus.canceled;

      default:
        return OrderStatus.none;
    }
  }
}
