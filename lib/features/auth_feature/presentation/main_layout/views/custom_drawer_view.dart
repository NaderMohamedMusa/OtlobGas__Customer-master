import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/main_layout/controllers/main_layout_controller.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/languages/app_translations.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text.dart';

class CustomDrawerView extends StatelessWidget {
  const CustomDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLayoutController>(
      builder: (controller) {
        return Theme(
          data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(
                  bodySmall: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 25))),
          child: Drawer(
            child: ListView(
              children: [
                Obx(() {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: CachedNetworkImage(
                        imageUrl: UserService.to.currentUser.value?.image ?? '',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: CustomText(
                      UserService.to.currentUser.value?.name ?? '',
                      max: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: AppColors.mainApp, fontSize: 22),
                    ),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.phoneActive,
                          height: 15,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10.0),
                        CustomText(
                          UserService.to.currentUser.value?.mobile ?? '',
                          max: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }),
                ListTile(
                  leading: SvgPicture.asset(Assets.homeBlueIC),
                  title: CustomText(LocaleKeys.homePage.tr),
                  onTap: () => controller.setIndex = 1,
                ),
                ListTile(
                  leading: SvgPicture.asset(Assets.userIC, height: 25),
                  title: CustomText(LocaleKeys.profile.tr),
                  onTap: () => controller.setIndex = 0,
                ),
                ListTile(
                  leading: SvgPicture.asset(Assets.editBlueIC),
                  title: CustomText(LocaleKeys.updateAccount.tr),
                  onTap: () {
                    controller.scaffoldKey.currentState!.closeDrawer();
                    Get.toNamed(Routes.editUser);
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(Assets.listOrderBlueIC),
                  title: CustomText(LocaleKeys.orderList.tr),
                  onTap: () => controller.setIndex = 3,
                ),
                ListTile(
                  leading: SvgPicture.asset(Assets.accountBalanceIC),
                  title: CustomText(LocaleKeys.wallet.tr),
                  onTap: () => controller.setIndex = 4,
                ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.location_on_outlined,
                //     color: AppColors.mainApp,
                //     size: 30,
                //   ),
                //   title: CustomText(LocaleKeys.locations.tr),
                //   onTap: () {
                //     Get.toNamed(Routes.locations);
                //   },
                // ),
                ListTile(
                  onTap: () {
                    controller.scaffoldKey.currentState!.closeDrawer();
                    Get.toNamed(Routes.privacy);
                  },
                  leading: const Icon(
                    Icons.privacy_tip_outlined,
                    color: AppColors.mainApp,
                    size: 30,
                  ),
                  title: CustomText(LocaleKeys.privacyPolicy.tr),
                ),
                ListTile(
                  onTap: () {
                    controller.scaffoldKey.currentState!.closeDrawer();
                    Get.toNamed(Routes.terms);
                  },
                  leading: const Icon(
                    Icons.article_outlined,
                    color: AppColors.mainApp,
                    size: 30,
                  ),
                  title: CustomText(LocaleKeys.termsConditions.tr),
                ),
                ListTile(
                  onTap: () {
                    controller.scaffoldKey.currentState!.closeDrawer();
                    Get.toNamed(Routes.contactUs);
                  },
                  leading: const Icon(
                    Icons.contact_support_outlined,
                    color: AppColors.mainApp,
                    size: 30,
                  ),
                  title: CustomText(LocaleKeys.contactUs.tr),
                ),
                ListTile(
                  onTap: () {
                    controller.scaffoldKey.currentState!.closeDrawer();
                    Get.toNamed(Routes.aboutApp);
                  },
                  leading: SvgPicture.asset(Assets.infoBlueIC),
                  title: CustomText(LocaleKeys.aboutApp.tr),
                ),
                ListTile(
                  leading: SvgPicture.asset(Assets.logOutRedIC),
                  title: CustomText(LocaleKeys.logout.tr),
                  onTap: () => Get.dialog(
                    GetBuilder<MainLayoutController>(
                      builder: (controller) {
                        return Stack(
                          children: [
                            AlertDialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              titlePadding: EdgeInsets.zero,
                              title: SizedBox(
                                width: Get.width,
                                child: Material(
                                  elevation: 24,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(LocaleKeys.logout.tr),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              onPressed: () =>
                                                  controller.logOut(),
                                              color: Colors.red,
                                              child: CustomText(
                                                LocaleKeys.yes.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                            CustomButton(
                                              onPressed: () => Get.back(),
                                              color: AppColors.mainApp,
                                              child: CustomText(
                                                LocaleKeys.no.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (controller.isLoading)
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
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.remove_circle_outline,color: Colors.red,
                  size: 30,),
                  title: CustomText(LocaleKeys.removeAccount.tr),
                  onTap: () => Get.dialog(
                    GetBuilder<MainLayoutController>(
                      builder: (controller) {
                        return Stack(
                          children: [
                            AlertDialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              titlePadding: EdgeInsets.zero,
                              title: SizedBox(
                                width: Get.width,
                                child: Material(
                                  elevation: 24,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(LocaleKeys.removeAccount.tr),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              onPressed: () =>
                                                  controller.removeAccount(),
                                              color: Colors.red,
                                              child: CustomText(
                                                LocaleKeys.yes.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                            CustomButton(
                                              onPressed: () => Get.back(),
                                              color: AppColors.mainApp,
                                              child: CustomText(
                                                LocaleKeys.no.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (controller.isLoading)
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
