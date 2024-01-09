import 'package:equatable/equatable.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart';

class OrdersPagenation extends Equatable {
  final int currentPage;
  final int lastPage;
  final List<Order> data;

  const OrdersPagenation({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  @override
  List<Object?> get props => [
        currentPage,
        lastPage,
        data,
      ];
}
