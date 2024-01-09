import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/widgets/loading_widget.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/account_balance/views/account_balance_view.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/profile/views/profile_view.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../order_feature/presentation/orders_list/views/orders_list_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/main_layout_controller.dart';
import 'custom_drawer_view.dart';

class MainLayoutView extends StatelessWidget {
  const MainLayoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLayoutController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                titlePadding: EdgeInsets.zero,
                title: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: context.size!.width,
                      child: Material(
                        elevation: 24,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 24),
                          child: Column(
                            children: [
                              LottieBuilder.asset(Assets.menuClose),
                              const SizedBox(height: 20.0),
                              CustomText(LocaleKeys.doYouWantToExitTheApp.tr),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    elevation: 2,
                                    color: AppColors.mainApp,
                                    child: CustomText(
                                      LocaleKeys.no.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                  const SizedBox(width: 20.0),
                                  CustomButton(
                                      elevation: 2,
                                      color: AppColors.scaffoldColor,
                                      child: CustomText(
                                        LocaleKeys.yes.tr,
                                      ),
                                      onPressed: () async {
                                        // await controller
                                        //     .changeUserActivity(
                                        //         isActive: false);
                                        // await controller
                                        //     .disposePage();
                                        if (Platform.isAndroid) {
                                          SystemNavigator.pop();
                                        } else {
                                          exit(0);
                                        }
                                      }),
                                ],
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
            );

            return false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: const CustomDrawerView(),
            key: controller.scaffoldKey,
            body: controller.isLoading
                ? const LoadingWidget()
                : Stack(
                    children: [
                      IndexedStack(
                        index: controller.currentIndex,
                        children: const [
                          ProfileView(),
                          HomeView(),
                          // SizedBox can't be changed if you want to get the empty space in the middle of the bottom nav bar
                          SizedBox(),
                          OrdersListView(),
                          AccountBalanceView(),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        right: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 5,
                                spreadRadius: 1,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width - 20,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30)),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child: BottomNavigationBar(
                                type: BottomNavigationBarType.fixed,
                                selectedItemColor: AppColors.mainApp,
                                unselectedItemColor: Colors.black,
                                currentIndex: controller.currentIndex,
                                onTap: (value) => controller.setIndex = value,
                                backgroundColor: Colors.white,
                                selectedLabelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 16.0),
                                unselectedLabelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 16.0),
                                items: <BottomNavigationBarItem>[
                                  BottomNavigationBarItem(
                                    label: LocaleKeys.account.tr,
                                    icon: SvgPicture.asset(
                                      Assets.bottPersonIC,
                                      color: controller.currentIndex == 0
                                          ? AppColors.mainApp
                                          : Colors.grey,
                                    ),
                                  ),
                                  BottomNavigationBarItem(
                                    label: LocaleKeys.currentOrder.tr,
                                    icon: SvgPicture.asset(
                                      Assets.botMyOrderIC,
                                      color: controller.currentIndex == 1
                                          ? AppColors.mainApp
                                          : Colors.grey,
                                    ),
                                  ),
                                  const BottomNavigationBarItem(
                                    label: '',
                                    icon: IgnorePointer(child: SizedBox()),
                                  ),
                                  BottomNavigationBarItem(
                                    label: LocaleKeys.myOrders.tr,
                                    icon: SvgPicture.asset(
                                      Assets.botCarIC,
                                      color: controller.currentIndex == 3
                                          ? AppColors.mainApp
                                          : Colors.grey,
                                    ),
                                  ),
                                  BottomNavigationBarItem(
                                    label: LocaleKeys.wallet.tr,
                                    icon: SvgPicture.asset(
                                      Assets.dollar,
                                      color: controller.currentIndex == 4
                                          ? AppColors.mainApp
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
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
}
