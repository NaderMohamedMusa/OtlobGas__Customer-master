import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/reset_password_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/utils/utils.dart';

class ChangePasswordController extends GetxController {
  ResetPasswordUseCase resetPasswordUseCase;
  ChangePasswordController({
    required this.resetPasswordUseCase,
  });
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  bool isLoading = false;

  @override
  void onInit() {
    emailController.text = Get.arguments;
    update();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    tokenController.dispose();

    super.dispose();
  }

  Future<void> changePassword() async {
    FocusScope.of(Get.context!).unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading = true;
    update();
    final result = await resetPasswordUseCase(
      email: emailController.text,
      token: tokenController.text,
      pass: passwordController.text,
      conPass: confirmPasswordController.text,
    );

    result.fold((failure) {
      isLoading = false;
      update();
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (message) {
      isLoading = false;
      update();
      ToastManager.showSuccess(message);
      Get.offAndToNamed(Routes.login);
    });
  }
}
