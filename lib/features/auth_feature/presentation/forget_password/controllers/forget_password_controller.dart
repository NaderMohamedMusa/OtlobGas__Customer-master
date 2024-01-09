import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/send_token_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/utils/utils.dart';

class ForgetPasswordController extends GetxController {
  SendTokenUseCase sendTokenUseCase;

  ForgetPasswordController({
    required this.sendTokenUseCase,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  bool isLoading = false;

  Future<void> sendToken() async {
    FocusScope.of(Get.context!).unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading = true;
    update();
    final result = await sendTokenUseCase(email: emailController.text);

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (message) {
      isLoading = false;
      update();
      ToastManager.showSuccess(message);
      Get.offAndToNamed(Routes.changePassword, arguments: emailController.text);
    });
  }

  @override
  void onInit() {
    emailController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
}
