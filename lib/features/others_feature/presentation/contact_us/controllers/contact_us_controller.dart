import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otlobgas_driver/features/others_feature/domain/use_cases/contact_us_use_case.dart';
import 'package:otlobgas_driver/features/others_feature/domain/use_cases/get_phone_number_use_case.dart';

import '../../../../../core/consts/toast_manager.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/custom_text.dart';

class ContactUsController extends GetxController {
  GetPhoneNumberUseCase getPhoneNumberUseCase;
  ContactUsUseCase contactUsUseCase;
  ContactUsController({
    required this.getPhoneNumberUseCase,
    required this.contactUsUseCase,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool isLoading = false;
  File? file;
  String? phoneNumber;

  Future<void> pickPicture() async {
    final ImagePicker picker = ImagePicker();

    bool? isCamera = await showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.camera,
                color: AppColors.mainApp,
              ),
              title: CustomText(LocaleKeys.getFromCamera.tr),
              onTap: () => Get.back(result: true),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.image, color: AppColors.mainApp),
              title: CustomText(LocaleKeys.getFromGallery.tr),
              onTap: () => Get.back(result: false),
            ),
          ],
        );
      },
    );
    if (isCamera == null) return;
    final XFile? image = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 20);
    if (image != null) {
      file = File(image.path);

      update();
    }
  }

  Future<void> getPhoneNumber() async {
    isLoading = true;
    update();
    final result = await getPhoneNumberUseCase();

    result.fold((failure) {
      isLoading = false;
      update();

      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      phoneNumber = result;
      isLoading = false;
      update();
    });
  }

  Future<void> contactUs() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading = true;
    update();

    final result = await contactUsUseCase(
      title: titleController.text,
      message: messageController.text,
      file: file != null ? file!.path : '',
    );
    isLoading = false;
    titleController.clear();
    messageController.clear();
    file = null;
    update();

    result.fold((failure) {
      ToastManager.showError(Utils.mapFailureToMessage(failure));
    }, (result) {
      isLoading = false;
      titleController.clear();
      messageController.clear();
      file = null;
      update();
      ToastManager.showSuccess(result);
    });
  }

  @override
  void onInit() async {
    await getPhoneNumber();

    super.onInit();
  }
}
