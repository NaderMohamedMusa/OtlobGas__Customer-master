import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/core/widgets/custom_loading.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/register/controllers/register_controller.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/validator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/font_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/password_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (controller) {
        return CustomLoading(
          widget: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: CustomText(
                LocaleKeys.createAccount.tr,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeightManger.bold, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    if (controller.selectedImage != null)
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(500),
                                          child: Image.file(
                                            File(controller.selectedImage!.path),
                                            fit: BoxFit.cover,
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                      )
                                    else
                                      SvgPicture.asset(
                                        Assets.userIC,
                                        height: 50,
                                      ),
                                    const SizedBox(height: 10.0),
                                    CustomText(
                                      LocaleKeys.selectProfilePicture.tr,
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

                      /// txt name
                      CustomText(LocaleKeys.fullName.tr),
                      const SizedBox(height: 10),

                      /// form name
                      CustomTextField(
                        prefixText: '     ',
                        prefixIcon: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: SvgPicture.asset(Assets.bottPersonIC)),
                        textEditingController: controller.nameController,
                        validator: (value) => AppValidator.validateFields(
                            value, ValidationType.name, context),
                        hintText: LocaleKeys.name.tr,
                      ),
                      const SizedBox(height: 20),

                      /// phone number
                      CustomText(LocaleKeys.phoneNumber.tr),
                      const SizedBox(height: 10),

                      /// form phone number
                      CustomTextField(
                        prefixText: '     ',
                        isNumberOnly: true,
                        keyboardType: TextInputType.phone,
                        prefixIcon: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: SvgPicture.asset(Assets.phoneActive)),
                        textEditingController: controller.mobileController,
                        validator: (value) => AppValidator.validateFields(
                            value, ValidationType.phone, context),
                        hintText: LocaleKeys.hintPhone.tr,
                      ),
                      const SizedBox(height: 20),

                      /// text mail
                      CustomText(LocaleKeys.mail.tr),
                      const SizedBox(height: 10),

                      /// form email
                      CustomTextField(
                        prefixText: '     ',
                        prefixIcon: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: SvgPicture.asset(
                              Assets.messagesIC,
                              height: 20,
                            )),
                        hintText: LocaleKeys.hintEmail.tr,
                        textEditingController:
                            controller.emailAddressController,
                        validator: (value) => AppValidator.validateFields(
                            value, ValidationType.email, context),
                      ),
                      const SizedBox(height: 20),

                      /// text password
                      CustomText(LocaleKeys.pass.tr),
                      const SizedBox(height: 10),

                      /// form password
                      PasswordTextField(
                        controller: controller.passController,
                      ),

                      const SizedBox(height: 20),

                      /// text confirm password
                      CustomText(LocaleKeys.confirmPass.tr),
                      const SizedBox(height: 10),

                      /// form confirm password
                      CustomTextField(
                        prefixText: '     ',
                        prefixIcon: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: SvgPicture.asset(Assets.activeSecretIC)),
                        isObscure: true,
                        hintText: LocaleKeys.writePass.tr,
                        textEditingController:
                            controller.confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.matchConfirmPassword.tr;
                          } else if (value.isNotEmpty &&
                              value != controller.passController.text) {
                            return LocaleKeys.matchConfirmPassword.tr;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Checkbox(
                            side: controller.acceptPolicyError
                                ? const BorderSide(color: Colors.red)
                                : null,
                            value: controller.acceptPolicy,
                            onChanged: (value) =>
                                controller.changeAcceptPolicyCheckBox(value!),
                          ),
                          CustomText(
                            LocaleKeys.acceptPolicy.tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: controller.acceptPolicyError
                                      ? Colors.red
                                      : Colors.grey,
                                  fontWeight: FontWeightManger.medium,
                                ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.terms),
                            child: CustomText(
                              LocaleKeys.termsConditions.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: controller.acceptPolicyError
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeightManger.bold,
                                  ),
                            ),
                          ),
                          CustomText(
                            " & ",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: controller.acceptPolicyError
                                      ? Colors.red
                                      : Colors.grey,
                                  fontWeight: FontWeightManger.medium,
                                ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.privacy),
                            child: CustomText(
                              LocaleKeys.privacyPolicy.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: controller.acceptPolicyError
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeightManger.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      ///Create Account button
                      CustomButton(
                        onPressed: () => controller.signUp(),
                        height: 50,
                        width: double.infinity,
                        child: Text(
                          LocaleKeys.createTheAccount.tr,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
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
            ),
          ),
          isLoading: controller.isLoading,
        );
      },
    );
  }
}
