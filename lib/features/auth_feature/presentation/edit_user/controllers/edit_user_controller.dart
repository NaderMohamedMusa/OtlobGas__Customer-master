import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/entities/user.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/edit_user_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/services/user_service.dart';
import '../../../../../core/utils/utils.dart';

class EditUserController extends GetxController {
  EditUserUseCase editUserUseCase;

  EditUserController({
    required this.editUserUseCase,
  });

  User? currentUser;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailAddressController = TextEditingController();
  late TextEditingController passController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController mobileController = TextEditingController();
  late TextEditingController confirmPasswordController =
      TextEditingController();
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

  Future<void> editAccount() async {
    FocusScope.of(Get.context!).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading = true;
    update();

    final result = await editUserUseCase(
      name: nameController.text,
      email: emailAddressController.text,
      image: selectedImage == null ? null : selectedImage,
      password: passController.text,
      confirmPassword: confirmPasswordController.text,
    );

    result.fold((failure) {
      isLoading = false;
      update();

      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (user) {
      isLoading = false;
      update();
      UserService.to.currentUser.value = user;
      ToastManager.showSuccess(LocaleKeys.editSuccess.tr);
    });
  }

  @override
  void onInit() async {
    emailAddressController.text = UserService.to.currentUser.value?.email ?? '';
    nameController.text = UserService.to.currentUser.value?.name ?? '';
    mobileController.text = UserService.to.currentUser.value?.mobile ?? '';
    currentUser = UserService.to.currentUser.value;
    super.onInit();
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passController.dispose();
    nameController.dispose();
    mobileController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
