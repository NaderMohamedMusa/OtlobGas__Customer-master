import 'package:get/get.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/forget_password/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(
        resetPasswordUseCase: Get.find(),
      ),
    );
  }
}
