import '../../domain/entities/orders_pagenation.dart';
import 'order_model.dart';

class OrdersPagenationModel extends OrdersPagenation {
  const OrdersPagenationModel({
    required super.currentPage,
    required super.lastPage,
    required super.data,
  });

  factory OrdersPagenationModel.fromMap(Map<String, dynamic> map) =>
      OrdersPagenationModel(
        currentPage: map['current_page'],
        lastPage: map['last_page'],
        data: List.from(map['data'])
            .map((e) => OrderModel.fromMap(e))
            .toList(),
      );
}