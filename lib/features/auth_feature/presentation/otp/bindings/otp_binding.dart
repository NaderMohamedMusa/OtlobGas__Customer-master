import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(
        verifyAccountUseCase: Get.find(),
        resendOtpCodeUseCase: Get.find(),
        verifyOtpUseCase: Get.find(),
        auth: Get.find(),
      ),
    );
  }
}
