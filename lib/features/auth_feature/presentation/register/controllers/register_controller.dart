import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/services/user_service.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/use_cases/register_use_case.dart';

class RegisterController extends GetxController {
  RegisterUseCase registerUseCase;

  RegisterController({
    required this.registerUseCase,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  XFile? selectedImage;

  bool acceptPolicy = false;
  bool acceptPolicyError = false;
  bool isLoading = false;

  Future<void> pickPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = image;

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

  Future<void> signUp() async {
    FocusScope.of(Get.context!).unfocus();
    if (!acceptPolicy) {
      acceptPolicyError = true;
      update();
    }
    if (!formKey.currentState!.validate() || acceptPolicyError) {
      return;
    }
    isLoading = true;
    update();

    final result = await registerUseCase(
      name: nameController.text,
      email: emailAddressController.text,
      mobile: mobileController.text,
      image: selectedImage,
      password: passController.text,
      confirmPassword: confirmPasswordController.text,
    );

    result.fold((failure) {
      isLoading = false;
      update();

      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (user) async {
      isLoading = false;
      update();
      UserService.to.currentUser.value = user;
      Get.offAndToNamed(Routes.otp, arguments: {
        'phoneNumber': mobileController.text,
      });
      ToastManager.showSuccess(LocaleKeys.registerSuccess.tr);
    });
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passController.dispose();
    nameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
