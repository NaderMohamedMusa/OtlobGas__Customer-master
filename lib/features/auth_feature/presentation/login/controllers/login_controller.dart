import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../domain/use_cases/login_use_case.dart';

class LoginController extends GetxController {
  LoginUserUseCase loginUserUseCase;

  LoginController({
    required this.loginUserUseCase,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController mobileController;
  late TextEditingController passController;

  File? selectedImage;

  bool acceptPolicy = false;
  bool acceptPolicyError = false;
  bool isLoading = false;

  Future<void> pickPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      update();
    }
  }

  void changeAcceptPolicyCheckBox(bool value) {
    acceptPolicy = value;
    if (value) {
      acceptPolicyError = false;
    }
    update();
  }

  Future<void> signIn() async {
    FocusScope.of(Get.context!).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading = true;
    update();

    final result = await loginUserUseCase(
      mobile: mobileController.text,
      password: passController.text,
    );

    result.fold((failure) async {
      isLoading = false;
      update();

      if (failure.runtimeType == UnVerifiedFailure) {
        Get.offAndToNamed(Routes.otp, arguments: {
          'phoneNumber': mobileController.text,
        });
      } else {
        ToastManager.showError(Utils.mapFailureToMessage(failure));
      }
    }, (user) {
      UserService.to.currentUser.value = user;

      isLoading = false;
      update();
      Get.offAndToNamed(Routes.mainLayout);
    });
  }

  @override
  void onInit() {
    mobileController = TextEditingController(text: kDebugMode ? '01123578061' : null,);
    passController = TextEditingController(text: kDebugMode ? '123456789' : null,);

    super.onInit();
  }

  @override
  void dispose() {
    mobileController.dispose();
    passController.dispose();

    super.dispose();
  }
}
