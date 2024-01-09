import 'package:equatable/equatable.dart';

class OrdersCount extends Equatable {
  final int all;
  final int today;

  const OrdersCount({
    required this.all,
    required this.today,
  });

  @override
  List<Object?> get props => [
        all,
        today,
      ];
}
