import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/utils/extensions.dart';
import 'package:otlobgas_driver/core/widgets/custom_loading.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/account_balance/controllers/account_balance_controller.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/consts/validator.dart';
import '../../../../../core/services/user_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/font_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../main_layout/views/components/main_layout_app_bar.dart';

class AccountBalanceView extends StatelessWidget {
  const AccountBalanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountBalanceController>(
      init: AccountBalanceController(
        chargeBalanceUseCase: Get.find(),
        getLastWeekUseCase: Get.find(),
      ),
      builder: (controller) {
        return Scaffold(
          appBar: const MainLayoutAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Obx(
                            () => Column(
                              children: [
                                CustomText(
                                  LocaleKeys.inTheWallet.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeightManger.regular,
                                        fontSize: 23,
                                      ),
                                ),
                                CustomText(
                                  double.parse(UserService
                                              .to.currentUser.value?.wallet
                                              .toStringAsFixed(3) ??
                                          '0')
                                      .toPrice,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeightManger.bold,
                                        color: AppColors.mainApp,
                                        fontSize: 25,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            onPressed: () => Get.dialog(
                              GetBuilder<AccountBalanceController>(
                                builder: (controller) {
                                  return CustomLoading(
                                    widget: AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      titlePadding: EdgeInsets.zero,
                                      title: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          SizedBox(
                                            width: context.width,
                                            child: Material(
                                              elevation: 24,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0,
                                                        horizontal: 24),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    /// balance_charge_window
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomText(
                                                          LocaleKeys
                                                              .balanceChargeWindow
                                                              .tr,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium
                                                              ?.copyWith(
                                                                  fontSize: 25),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),

                                                    /// text name
                                                    CustomText(LocaleKeys
                                                        .rechargeCardNumber.tr),
                                                    const SizedBox(height: 10),

                                                    /// form name
                                                    Form(
                                                      key: controller.formKey,
                                                      child: CustomTextField(
                                                        maxLength: 15,
                                                        prefixText: '     ',
                                                        prefixIcon: CircleAvatar(
                                                            radius: 25,
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[300],
                                                            child: SvgPicture
                                                                .asset(Assets
                                                                    .bottPersonIC)),
                                                        textEditingController:
                                                            controller
                                                                .cardNumberController,
                                                        isNumberOnly: true,
                                                        validator: (value) =>
                                                            AppValidator
                                                                .validateFields(
                                                          value,
                                                          ValidationType
                                                              .cardNumber,
                                                          context,
                                                        ),
                                                        hintText:
                                                            '123456789413126',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    CustomButton(
                                                      onPressed: () =>
                                                          controller
                                                              .chargeBalance(),
                                                      width: double.infinity,
                                                      color: AppColors.mainApp,
                                                      borderRadius: 50,
                                                      child: CustomText(
                                                        LocaleKeys
                                                            .rechargeTheBalance
                                                            .tr,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -15,
                                            right: -15,
                                            child: GestureDetector(
                                              onTap: () => Get.back(),
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 16,
                                                child: Icon(
                                                  Icons.close,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    isLoading: controller.isLoading,
                                  );
                                },
                              ),
                            ),
                            height: 50,
                            color: AppColors.mainApp,
                            borderRadius: 5,
                            child: CustomText(
                              LocaleKeys.rechargeTheBalance.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeightManger.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                if (controller.lastWeek.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Chart(
                            state: ChartState<void>(
                              data: ChartData(
                                [
                                  controller.lastWeek
                                      .map((e) =>
                                          ChartItem<void>(e.value.toDouble()))
                                      .toList(),
                                ],
                                valueAxisMaxOver: 1,
                                
                              ),
                              behaviour: const ChartBehaviour(
                                scrollSettings: ScrollSettings(),
                              ),
                              itemOptions: BarItemOptions(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                barItemBuilder: (_) => const BarItem(
                                  color: AppColors.mainApp,
                                  radius: BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                ),
                              ),
                              backgroundDecorations: [
                                GridDecoration(
                                  gridColor: Theme.of(context).dividerColor,

                                  horizontalAxisStep: 1,
                                  showHorizontalValues: true,
                                  horizontalValuesPadding:
                                      const EdgeInsets.only(right: 5),
                                  horizontalLegendPosition:
                                      HorizontalLegendPosition.start,
                                  endWithChartHorizontal: true,
                                  showVerticalValues: true,
                                  showVerticalGrid: false,
                                  verticalAxisValueFromIndex: (index) {
                                    return controller.lastWeek[index].date;
                                  },
                                  verticalValuesPadding:
                                      const EdgeInsets.only(top: 5),
                                  endWithChartVertical: true,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget bottomTitles(double value, TitleMeta meta) {
  //   const style = TextStyle(color: Color(0xff939393), fontSize: 10);
  //   // String text;
  //   // switch (value.toInt()) {
  //   //   case 0:
  //   //     text = 'Sat';
  //   //     break;
  //   //   case 1:
  //   //     text = 'Sun';
  //   //     break;
  //   //   case 2:
  //   //     text = 'Mon';
  //   //     break;
  //   //   case 3:
  //   //     text = 'Tus';
  //   //     break;
  //   //   case 4:
  //   //     text = 'Wed';
  //   //     break;
  //   //   case 5:
  //   //     text = 'Thr';
  //   //     break;
  //   //   case 6:
  //   //     text = 'Fri';
  //   //     break;
  //   //   default:
  //   //     text = '';
  //   //     break;
  //   // }
  //   return GetBuilder<AccountBalanceController>(
  //     builder: (controller) {
  //       return SideTitleWidget(
  //         axisSide: meta.axisSide,
  //         child: Text(
  //           controller.lastWeek[value.toInt()].date,
  //           style: style,
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget leftTitles(double value, TitleMeta meta) {
  //   if (value == meta.max) {
  //     return Container();
  //   }
  //   const style = TextStyle(
  //     color: Color(
  //       0xff939393,
  //     ),
  //     fontSize: 10,
  //   );
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: Text(
  //       meta.formattedValue,
  //       style: style,
  //     ),
  //   );
  // }

  // List<BarChartGroupData> getData(List currentLast7days) {
  //   List<BarChartGroupData> test = [];
  //   for (var i = 0; i < currentLast7days.length; i++) {
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //     test.add(
  //       BarChartGroupData(
  //         x: i,
  //         barsSpace: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: currentLast7days[i].value.toDouble(),
  //             gradient: const LinearGradient(
  //               colors: [
  //                 AppColors.powerOnFirstGradientColor,
  //                 AppColors.powerOnLastGradientColor,
  //               ],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  //   return test;
  // }
}
