import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/consts/assets.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/theme/app_colors.dart';
import 'package:otlobgas_driver/core/theme/font_manager.dart';
import 'package:otlobgas_driver/core/widgets/custom_button.dart';
import 'package:otlobgas_driver/core/widgets/custom_text.dart';
import 'package:otlobgas_driver/core/widgets/custom_text_field.dart';

import '../../controllers/current_order_controller.dart';

// ignore: must_be_immutable
class CancelOrder extends StatelessWidget {
  CancelOrder({super.key, required this.result});
  String result;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          result,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              onPressed: () {
                if (Get.isDialogOpen!) {
                  Get.back();
                }
              },
              color: Colors.red,
              child: CustomText(
                LocaleKeys.cancel.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            CustomButton(
              onPressed: () => CurrentOrderController.to.cancelConfirmOrder(),
              color: AppColors.mainApp,
              child: CustomText(
                LocaleKeys.continue_.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        CustomButton(
          onPressed: () {
            if (Get.isDialogOpen!) {
              Get.back();
            }
            Get.dialog(
              GetX<CurrentOrderController>(
                builder: (controller) {
                  return Stack(
                    children: [
                      AlertDialog(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        titlePadding: const EdgeInsets.all(20),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: controller.formKey,
                              child: CustomTextField(
                                labelText: CustomText(
                                  LocaleKeys.reason.tr,
                                ),
                                textEditingController:
                                    controller.reasonController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.emptyCacheMessage.tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                CustomButton(
                                  onPressed: () {
                                    if (Get.isDialogOpen!) {
                                      Get.back();
                                    }
                                  },
                                  color: Colors.red,
                                  child: CustomText(
                                    LocaleKeys.cancel.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Spacer(),
                                CustomButton(
                                  onPressed: () =>
                                      controller.cancelOrderWithReasonConfirm(),
                                  color: AppColors.mainApp,
                                  child: CustomText(
                                    LocaleKeys.continue_.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      if (controller.isLoading.value)
                        Container(
                          color: Colors.grey.withOpacity(.5),
                          child: Center(
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: LottieBuilder.asset(Assets.loading),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            );
          },
          color: AppColors.lightRed,
          child: Text(
            LocaleKeys.cancelBecauseOf.tr,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeightManger.regular,
                  color: Colors.white,
                  fontSize: 20,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
