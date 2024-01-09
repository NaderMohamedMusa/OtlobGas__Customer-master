import 'package:get/get.dart';

import '../controllers/current_order_controller.dart';

class CurrentOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurrentOrderController>(
      () => CurrentOrderController(
        checkAvailableOrderUseCase: Get.find(),
        listenToOrderUseCase: Get.find(),
        subscribeOrderUseCase: Get.find(),
        assignOrderUseCase: Get.find(),
        rejectOrderUseCase: Get.find(),
        cancelOrderUseCase: Get.find(),
        cancelConfirmOrderUseCase: Get.find(),
        cancelOrderWithReasonUseCase: Get.find(),
      ),
    );
  }
}
