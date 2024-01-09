import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/utils/extensions.dart';
import 'package:otlobgas_driver/features/order_feature/domain/entities/order.dart';
import 'package:otlobgas_driver/features/order_feature/presentation/current_order/controllers/current_order_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/languages/app_translations.dart';
import '../../../../../../core/routes/app_pages.dart';
import '../../../../../../core/services/language_service.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text.dart';

class CurrentOrderSlidePanel extends GetView<CurrentOrderController> {
  const CurrentOrderSlidePanel({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      isDraggable: true,
      defaultPanelState: PanelState.OPEN,
      minHeight: Get.height * 0.50,
      maxHeight: Get.height * 0.51,
      color: Colors.white,
      header: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
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
                      color: AppColors.notActive,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),
        ],
      ),
      panel: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SvgPicture.asset(
                //   Assets.clockBlueIC,
                //   width: 30,
                // ),
                // const SizedBox(width: 10),
                LottieBuilder.asset(
                  Assets.carLoading,
                  width: 120,
                  height: 80,
                ),
                CustomText(
                  Intl.pluralLogic(
                    0,
                    // controller.order.value!.time,
                    locale: Intl.canonicalizedLocale(
                      LanguageService.to.savedLang.value,
                    ),
                    other: '${0} ${LocaleKeys.minutesToArrive.tr}',
                    one: '${0} ${LocaleKeys.minuteToArrive.tr}',
                    zero: LocaleKeys.arrived.tr,
                  ),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeightManger.medium,
                        color: AppColors.mainApp,
                        fontSize: 20,
                      ),
                ),
                const SizedBox(width: 20),
              ],
            ),

            Container(
                height: 1, color: Colors.grey[400], width: double.infinity),
            const SizedBox(height: 10),

            /// number of gas cylinder ordered
            Row(
              children: [
                SvgPicture.asset(Assets.carBlueIC),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  LocaleKeys.numberGasCylinder.tr,
                ),
                const Spacer(),

                //   number of cylinder required
                CustomText(
                  '${order.quantity}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeightManger.regular,
                        color: AppColors.mainApp,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Container(
                height: 1, color: Colors.grey[400], width: double.infinity),
            const SizedBox(height: 10),

            /// delivery cost
            Row(
              children: [
                SvgPicture.asset(Assets.reciteBlueIC),
                const SizedBox(width: 10),
                CustomText(
                  LocaleKeys.deliveryCost.tr,
                ),
                const Spacer(),
                CustomText(
                  double.parse(order.delivery.toStringAsExponential(3)).toPrice,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeightManger.regular,
                        color: AppColors.mainApp,
                        fontSize: 20,
                      ),
                ),
              ],
            ),

            /// delivery Driver name
            const SizedBox(height: 10),
            Container(
                height: 1, color: Colors.grey[400], width: double.infinity),
            const SizedBox(height: 15),

            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: AppColors.mainApp,
                ),
                const SizedBox(width: 10),
                CustomText(
                  LocaleKeys.driverName.tr,
                ),
                const Spacer(),
                CustomText(
                  order.driver.name,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeightManger.regular,
                        color: AppColors.mainApp,
                        fontSize: 20,
                      ),
                ),
              ],
            ),

            /// delivery vehicleNumber
            const SizedBox(height: 10),
            Container(
                height: 1, color: Colors.grey[400], width: double.infinity),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.directions_car_outlined,
                  color: AppColors.mainApp,
                ),
                const SizedBox(width: 10),
                CustomText(
                  LocaleKeys.vehicleID.tr,
                ),
                const Spacer(),
                CustomText(
                  order.driver.vehicleNumber,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeightManger.regular,
                        color: AppColors.mainApp,
                        fontSize: 20,
                      ),
                ),
              ],
            ),

            /// delivery vehicle Type
            const SizedBox(height: 10),
            Container(
                height: 1, color: Colors.grey[400], width: double.infinity),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.directions_car_outlined,
                  color: AppColors.mainApp,
                ),
                const SizedBox(width: 10),
                CustomText(
                  LocaleKeys.vehicleType.tr,
                ),
                const Spacer(),
                CustomText(
                  order.driver.vehicleType,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeightManger.regular,
                        color: AppColors.mainApp,
                        fontSize: 20,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// chat with me button
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  onPressed: () => Get.toNamed(
                    Routes.chat,
                    arguments: {
                      'customer': order.driver,
                      'address': order.address,
                    },
                  ),
                  height: 45,
                  color: AppColors.mainApp,
                  child: Text(
                    LocaleKeys.contactMe.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeightManger.regular,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                  ),
                )),
                // if order is not accepted show these buttons
                const SizedBox(width: 20),

                /// cancel button
                Expanded(
                    child: CustomButton(
                  onPressed: () => controller.cancelOrder(),
                  height: 45,
                  color: Colors.red,
                  child: Text(
                    LocaleKeys.cancel.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeightManger.regular,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                  ),
                )),
              ],
            ),

            // Row(
            //   children: [
            //     Expanded(
            //         child: CustomButton(
            //       onPressed: () => Get.toNamed(
            //         Routes.chat,
            //         arguments: {
            //           'customer': controller.order.value?.customer,
            //           'address': controller.order.value!.address,
            //         },
            //       ),
            //       height: 45,
            //       color: AppColors.mainApp,
            //       child: Text(
            //         LocaleKeys.contactMe.tr,
            //         style: Theme.of(context)
            //             .textTheme
            //             .headlineMedium!
            //             .copyWith(
            //               fontWeight: FontWeightManger.regular,
            //               color: Colors.white,
            //               fontSize: 20,
            //             ),
            //       ),
            //     )),

            //     // if order is not accepted show these buttons
            //     if (controller.order.value!.status !=
            //         OrderStatus.delivered) ...[
            //       const SizedBox(width: 10),

            //       /// received button
            //       Expanded(
            //           child: CustomButton(
            //         onPressed: () {
            //           // controller.toggleBetweenDeliveredAndCheck();
            //         },
            //         height: 45,
            //         color: Colors.green,
            //         child: Text(
            //           LocaleKeys.received.tr,
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineMedium!
            //               .copyWith(
            //                 fontWeight: FontWeightManger.regular,
            //                 color: Colors.white,
            //                 fontSize: 20,
            //               ),
            //         ),
            //       )),
            //       const SizedBox(width: 10),

            //       /// cancel button
            //       Expanded(
            //           child: CustomButton(
            //         onPressed: () {
            //           // control.cancelOrder();
            //         },
            //         height: 45,
            //         color: Colors.red,
            //         child: Text(
            //           LocaleKeys.cancel.tr,
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineMedium!
            //               .copyWith(
            //                 fontWeight: FontWeightManger.regular,
            //                 color: Colors.white,
            //                 fontSize: 20,
            //               ),
            //         ),
            //       )),
            //     ],
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
