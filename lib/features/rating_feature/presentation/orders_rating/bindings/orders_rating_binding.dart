import 'package:get/get.dart';

import '../controllers/orders_rating_controller.dart';

class OrdersRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersRatingController>(
      () => OrdersRatingController(
        getRatingUseCase: Get.find(),
      ),
    );
  }
}
