import 'dart:async';

import 'package:get/get.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';

class SplashController extends GetxController {
  navigate() async {
    if (UserService.to.currentUser.value != null) {
      Get.offAllNamed(Routes.mainLayout);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  void onReady() async {
    Timer(const Duration(seconds: 3), () async => await navigate());

    super.onReady();
  }
}
