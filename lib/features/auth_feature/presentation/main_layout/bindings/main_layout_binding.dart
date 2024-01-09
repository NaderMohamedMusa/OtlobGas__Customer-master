import 'package:get/get.dart';

import '../controllers/main_layout_controller.dart';

class MainLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLayoutController>(
      () => MainLayoutController(
        logoutUserUseCase: Get.find(),
          removeAccountUseCase:Get.find(),
        listenToUserUseCase: Get.find(),
        initPusherUseCase: Get.find(),
        disconnectPusherUseCase: Get.find(),
      ),
    );
  }
}
