import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/utils/extensions.dart';
import 'package:otlobgas_driver/core/widgets/custom_loading.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/otp/controllers/otp_controller.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/validator.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class OtpView extends StatelessWidget {
  const OtpView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      builder: (controller) {
        return CustomLoading(
          widget: Scaffold(
            appBar: AppBar(
              title: CustomText(
                LocaleKeys.verifyYourAccount.tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white, fontSize: 25),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(children: [
                const SizedBox(height: 30.0),

                ///   Phone Number Text
                CustomText(
                  LocaleKeys.phoneNumber.tr,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10.0),

                ///   Phone Number TextField
                CustomTextField(
                  readOnly: true,
                  prefixIcon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    child: SvgPicture.asset(
                      Assets.phoneActive,
                      height: 20,
                    ),
                  ),
                  textEditingController: controller.phoneNumber,
                ),
                const SizedBox(height: 30.0),

                ///   Code Text
                CustomText(
                  LocaleKeys.verificationCode.tr,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10.0),

                ///   Code Field
                Form(
                  key: controller.formKey,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 4,
                      defaultPinTheme: PinTheme(
                        height: 45,
                        width: 45,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 26, color: Colors.black),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.notActive),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      controller: controller.code,
                      onCompleted: (value) async {
                        await controller.verifyOtpCode(
                          code: controller.code.text,
                          phone: controller.phoneNumber.text,
                        );
                      },
                      validator: (value) => AppValidator.validateFields(
                          value, ValidationType.validationCode, context),
                    ),
                  ),
                ),

                const SizedBox(height: 40.0),
                TextButton(
                  onPressed: controller.timeCounter != 0
                      ? null
                      : () async {
                          await controller.resendOtpCode(
                            phone: controller.phoneNumber.text,
                          );
                        },
                  child: CustomText(
                    LocaleKeys.resendCode.tr +
                        (controller.timeCounter == 0
                            ? ' '
                            : ' 00:${controller.timeCounter.getDurationReminder} '),
                    decoration: controller.timeCounter == 0
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),

                const SizedBox(height: 40.0),

                /// sign button
                CustomButton(
                  width: double.infinity,
                  height: 46,
                  onPressed: () async => await controller.verifyOtpCode(
                    code: controller.code.text,
                    phone: controller.phoneNumber.text,
                  ),
                  child: CustomText(
                    LocaleKeys.verifyYourAccount.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ]),
            ),
          ),
          isLoading: controller.isLoading,
        );
      },
    );
  }
}
