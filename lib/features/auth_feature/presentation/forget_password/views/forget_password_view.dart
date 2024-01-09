import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/widgets/custom_loading.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/validator.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: CustomText(
              LocaleKeys.accountRecovery.tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white, fontSize: 25),
            ),
          ),
          body: CustomLoading(
            widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(children: [
                const SizedBox(height: 20.0),
                CustomText(
                  LocaleKeys.accountRecoveryNote.tr,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),

                ///   phone number
                CustomText(
                  LocaleKeys.emailOrPhone.tr,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10.0),

                ///   phone number
                Form(
                  key: controller.formKey,
                  child: CustomTextField(
                    prefixText: '     ',
                    prefixIcon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[300],
                        child: SvgPicture.asset(Assets.phoneActive)),
                    hintText: LocaleKeys.enterEmailOrPhone.tr,
                    textEditingController: controller.emailController,
                    validator: (value) => AppValidator.validateFields(
                        value, ValidationType.email, context),
                  ),
                ),

                const SizedBox(height: 40.0),

                /// sign button
                CustomButton(
                  width: double.infinity,
                  height: 46,
                  onPressed: () => controller.sendToken(),
                  child: CustomText(
                    LocaleKeys.accountRecovery.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ]),
            ),
            isLoading: controller.isLoading,
          ),
        );
      },
    );
  }
}
