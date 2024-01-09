import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/theme/app_colors.dart';
import 'package:otlobgas_driver/features/others_feature/presentation/contact_us/controllers/contact_us_controller.dart';

import '../../../../../core/theme/font_manager.dart';
import '../../../../../core/widgets/back_button_widget.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: CustomText(
              LocaleKeys.contactUs.tr,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
            ),
            actions: const [
              SizedBox(width: 10),
              BackButtonWidget(),
              SizedBox(width: 10),
            ],
          ),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: Form(
              key: controller.formKey,
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  GestureDetector(
                    onTap: controller.pickPicture,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 110,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 5.0),
                                if (controller.file != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(500),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: Image.file(
                                        controller.file!,
                                        fit: BoxFit.cover,
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  )
                                else
                                  const Icon(
                                    Icons.image,
                                    color: AppColors.mainApp,
                                    size: 40,
                                  ),
                                const SizedBox(height: 10.0),
                                CustomText(
                                  LocaleKeys.selectPicture.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.mainApp,
                                      ),
                                ),
                                const SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  ///  title
                  CustomText(LocaleKeys.title.tr),
                  const SizedBox(height: 10),

                  /// form title
                  CustomTextField(
                    textEditingController: controller.titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.emptyTitle.tr;
                      }
                      return null;
                    },
                    hintText: LocaleKeys.title.tr,
                  ),
                  const SizedBox(height: 20),

                  /// message
                  CustomText(LocaleKeys.message.tr),
                  const SizedBox(height: 10),

                  /// form message
                  CustomTextField(
                    textEditingController: controller.messageController,
                    isMultiLine: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.emptyMessage.tr;
                      }
                      return null;
                    },
                    hintText: LocaleKeys.message.tr,
                  ),
                  const SizedBox(height: 20),

                  /// text mail
                  CustomText(
                      '${LocaleKeys.contactUs.tr}: ${controller.phoneNumber ?? ''}'),
                  const SizedBox(height: 20),

                  ///Create Account button
                  CustomButton(
                    onPressed: () => controller.contactUs(),
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      LocaleKeys.send.tr,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeightManger.medium,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
