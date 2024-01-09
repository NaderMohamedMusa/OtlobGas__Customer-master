import 'package:get/get.dart';

import '../controllers/edit_location_controller.dart';

class EditLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditLocationController>(
      () => EditLocationController(
        editLocationUseCase: Get.find(),
      ),
    );
  }
}
