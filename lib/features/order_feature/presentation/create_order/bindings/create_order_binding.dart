import 'package:get/get.dart';

class CreateOrderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<CurrentOrderController>(
    //   () => CurrentOrderController(
    //     checkAvailableOrderUseCase: Get.find(),
    //     initPusherOrderUseCase: Get.find(),
    //     listenToOrderUseCase: Get.find(),
    //     disconnectPusherOrderUseCase: Get.find(),
    //     acceptOrderUseCase: Get.find(),
    //     deliveredOrderUseCase: Get.find(),
    //     cancelOrderUseCase: Get.find(),
    //     rejectOrderUseCase: Get.find(),
    //   ),
    // );
  }
}
