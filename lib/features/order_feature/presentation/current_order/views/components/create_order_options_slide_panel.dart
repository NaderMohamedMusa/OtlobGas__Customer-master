import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/utils/extensions.dart';
import 'package:otlobgas_driver/features/order_feature/presentation/current_order/controllers/current_order_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/services/user_service.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text.dart';

class CreateOrderOptionsSlidePanel extends StatelessWidget {
  const CreateOrderOptionsSlidePanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CurrentOrderController>(
      builder: (controller) {
        return SlidingUpPanel(
          isDraggable: true,
          minHeight: MediaQuery.of(context).size.height * 0.3,
          maxHeight: MediaQuery.of(context).size.height * 0.48,
          color: Colors.white,
          header: Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
          defaultPanelState: PanelState.OPEN,
          panel: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 39,
                    ),

                    /// number of Gas cylinder
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.mainApp),
                              child: Image.asset(Assets.ambobaIC),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  LocaleKeys.numberGasCylinder.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeightManger.regular,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        controller.changeCount(increase: true),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  CustomText(
                                    controller.quantity.value.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            fontSize: 22, color: Colors.grey),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        controller.changeCount(increase: false),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 10, thickness: 1),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// payment - cash
                          Row(
                            children: [
                              CupertinoSwitch(
                                value: controller.isCash.value,
                                activeColor: AppColors.mainApp,
                                onChanged: (bool value) =>
                                    controller.changePaymentMethod(),
                              ),
                              CustomText(
                                LocaleKeys.payCash.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 18),
                              )
                            ],
                          ),

                          /// payment - wallet
                          Row(
                            children: [
                              CupertinoSwitch(
                                value: !controller.isCash.value,
                                activeColor: AppColors.mainApp,
                                onChanged: (bool value) =>
                                    controller.changePaymentMethod(),
                              ),
                              CustomText(
                                LocaleKeys.wallet.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 18),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 10, thickness: 1),

                    /// number  of Gas cylinder needed

                    /// your wallet balance
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.circleRedDollarIC),
                              const SizedBox(width: 10),
                              CustomText(
                                LocaleKeys.yourWalletBalance.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 18, color: Colors.red),
                              ),
                            ],
                          ),
                          CustomText(
                            UserService.to.currentUser.value!.wallet.toPrice,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 18, color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 10, thickness: 1),

                    /// delivery cost
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.reciteBlueIC),
                              const SizedBox(width: 10),
                              CustomText(
                                LocaleKeys.deliveryCost.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontSize: 18, color: AppColors.mainApp),
                              ),
                            ],
                          ),
                          CustomText(
                            controller.totalPrice.value > 0
                                ? controller.totalPrice.value.toPrice
                                : double.parse(
                                    controller.order.value!.totalPrice
                                        .toStringAsExponential(3),
                                  ).toPrice,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontSize: 18, color: AppColors.mainApp),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 10, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.airline_stops_sharp,
                                color: AppColors.mainApp,
                              ),
                              const SizedBox(width: 10),
                              CustomText(
                                LocaleKeys.distance.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontSize: 18, color: AppColors.mainApp),
                              ),
                            ],
                          ),
                          CustomText(
                            controller.order.value!.distance.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontSize: 18, color: AppColors.mainApp),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () => controller.assignOrder(),
                height: 45,
                borderRadius: 0,
                width: double.infinity,
                color: AppColors.mainApp,
                child: CustomText(
                  LocaleKeys.confirmOrder.tr,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 25, fontFamily: FontConstants.fontFamily),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
