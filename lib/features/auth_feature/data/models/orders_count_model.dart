import '../../domain/entities/orders_count.dart';

class OrdersCountModel extends OrdersCount {
  const OrdersCountModel({
    required super.all,
    required super.today,
 
  });

  factory OrdersCountModel.fromMap(Map<String, dynamic> map) =>
      OrdersCountModel(
        all: map['all'],
        today: map['all_today'],
       
      );
}
