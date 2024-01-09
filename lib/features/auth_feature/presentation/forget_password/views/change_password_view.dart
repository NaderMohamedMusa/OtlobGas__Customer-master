import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/forget_password/controllers/change_password_controller.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/validator.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/password_text_field.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: CustomText(
              LocaleKeys.resetThePassword.tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white, fontSize: 25),
            ),
          ),
          body: Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.all(14.0),
              children: [
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
                  textEditingController: controller.emailController,
                  validator: (value) => AppValidator.validateFields(
                      value, ValidationType.email, context),
                ),
                const SizedBox(height: 20),

                /// text mail
                CustomText(LocaleKeys.token.tr),
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
                  hintText: LocaleKeys.hintToken.tr,
                  textEditingController: controller.tokenController,
                ),
                const SizedBox(height: 20),

                /// text password
                CustomText(LocaleKeys.pass.tr),
                const SizedBox(height: 10),

                /// form password
                PasswordTextField(
                  controller: controller.passwordController,
                ),

                const SizedBox(height: 20),

                /// text confirm password
                CustomText(LocaleKeys.confirmPass.tr),
                const SizedBox(height: 10),

                /// form confirm password
                PasswordTextField(
                  controller: controller.confirmPasswordController,
                ),

                const SizedBox(height: 20),
                /* 
          const SizedBox(height: 30.0),
          ///   Or
          CustomText(
            Utils.localization?.or,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeightManger.bold),
          ),
          const SizedBox(height: 30.0),
        
           ///   Email address
          CustomText(
            Utils.localization?.mail,
            textAlign: TextAlign.center,
          ),
        
          const SizedBox(height: 10.0),
        
          ///   Email address
          Form(
            key: recoverAccountProvider.formKey,
            child: CustomTextField(
              prefixText: '     ',
              prefixIcon: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[300],
                  child: SvgPicture.asset(
                    Assets.messagesIC,
                    height: 20,
                  )),
              hintText: Utils.localization?.hint_email ?? "",
              textEditingController:
                  recoverAccountProvider.emailAddressController,
              validator: (value) => AppValidator.validateFields(
                  value, ValidationType.email, context),
            ),
          ), */

                const SizedBox(height: 40.0),

                /// sign button
                CustomButton(
                  width: double.infinity,
                  height: 46,
                  onPressed: controller.changePassword,
                  child: CustomText(
                    LocaleKeys.resetThePassword.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
