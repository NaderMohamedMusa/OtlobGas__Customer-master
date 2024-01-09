import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/widgets/custom_loading.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/login/controllers/login_controller.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/consts/validator.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/services/language_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/password_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return CustomLoading(
          widget: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.splash,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// top image
                SizedBox(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.splash,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Image.asset(Assets.otlobGas, height: 120, width: 120),
                          const Spacer(flex: 4),
                          Column(
                            children: [
                              const SizedBox(height: 5.0),
                              Image.asset(Assets.splashTop,
                                  height: 60, width: 60),
                              Image.asset(Assets.splashCenter,
                                  height: 120, width: 150),
                            ],
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 0.5),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(Utils.isRTL ? 0 : pi),
                          child: CustomPaint(
                            size: Size(MediaQuery.of(context).size.width,
                                (60).toDouble()),
                            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          child: Form(
                            key: controller.formKey,
                            child: ListView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    /// login text
                                    ///
                                    CustomText(
                                      LocaleKeys.login.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                /// form phone number
                                CustomTextField(
                                  prefixText: '     ',
                                  isNumberOnly: true,
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.grey[300],
                                      child:
                                          SvgPicture.asset(Assets.phoneActive)),
                                  textEditingController:
                                      controller.mobileController,
                                  hintText: LocaleKeys.hintPhone.tr,
                                  validator: (value) =>
                                      AppValidator.validateFields(
                                          value, ValidationType.phone, context),
                                ),
                                const SizedBox(height: 20),

                                /// password

                                PasswordTextField(
                                  controller: controller.passController,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                /// sign button
                                CustomButton(
                                  width: double.infinity,
                                  height: 46,
                                  onPressed: () => controller.signIn(),
                                  child: CustomText(
                                    LocaleKeys.login.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                /// Create new account
                                CustomButton(
                                  width: double.infinity,
                                  borderColor: Colors.red,
                                  height: 46,
                                  color: Colors.white,
                                  onPressed: () => Get.toNamed(Routes.register),
                                  child: Text(
                                    LocaleKeys.createNewAccount.tr,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                const SizedBox(height: 30),

                                /// text forget account data
                                GestureDetector(
                                  onTap: () =>
                                      Get.toNamed(Routes.forgetPassword),
                                  child: Center(
                                    child: CustomText(
                                      LocaleKeys.forgetYourData.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(fontSize: 20),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                /// language button changes
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // en button
                                      CustomButton(
                                        width: 100,
                                        height: 40,
                                        borderRadius: 4,
                                        borderColor: !Utils.isRTL
                                            ? AppColors.mainApp
                                            : AppColors.notActive,
                                        color: !Utils.isRTL
                                            ? Colors.white
                                            : AppColors.notActive,
                                        onPressed: () => LanguageService.to
                                            .onChangeLang(lang: 'en'),
                                        child: Text(
                                          LocaleKeys.englishLang.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: !Utils.isRTL
                                                      ? AppColors.mainApp
                                                      : Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),

                                      // ar button
                                      CustomButton(
                                        height: 40,
                                        width: 100,
                                        borderRadius: 4,
                                        borderColor: Utils.isRTL
                                            ? AppColors.mainApp
                                            : AppColors.notActive,
                                        color: Utils.isRTL
                                            ? Colors.white
                                            : AppColors.notActive,
                                        onPressed: () => LanguageService.to
                                            .onChangeLang(lang: 'ar'),
                                        child: CustomText(
                                          LocaleKeys.arabicLang.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: Utils.isRTL
                                                      ? AppColors.mainApp
                                                      : Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          isLoading: controller.isLoading,
        );
      },
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(size.width * 0.9609041, size.height * -0.2992638,
        size.width * 0.6896164, size.height * 0.0802454);
    path0.quadraticBezierTo(
        size.width * 0.5270411, size.height * 0.2913497, 0, size.height);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
