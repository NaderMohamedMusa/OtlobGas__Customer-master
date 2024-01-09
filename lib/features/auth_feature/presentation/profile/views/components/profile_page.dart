import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/profile/controllers/profile_controller.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_cached_image.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../core/widgets/mobile_number_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          body: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              GetX<UserService>(
                builder: (userService) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CustomCachedNetworkImage(
                            url: userService.currentUser.value?.image ?? '',
                            boxFit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        userService.currentUser.value?.name ??
                            LocaleKeys.guest.tr,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeightManger.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MobileNumberWidget(
                            mobile: userService.currentUser.value?.mobile ?? '',
                            // mobile: profilePageProvider.currentUser?.mobile,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (userService.currentUser.value?.email != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.messagesIC,
                              color: Colors.black,
                              height: 17,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              userService.currentUser.value?.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            CustomText(
                              LocaleKeys.totalOrders.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeightManger.regular,
                                    fontSize: 25,
                                  ),
                            ),
                            CustomText(
                              controller.ordersCount?.all.toString() ?? '0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeightManger.bold,
                                    color: AppColors.mainApp,
                                    fontSize: 30,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            CustomText(
                              LocaleKeys.todaysOrders.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeightManger.regular,
                                    fontSize: 25,
                                  ),
                            ),
                            CustomText(
                              controller.ordersCount?.today.toString() ?? '0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeightManger.bold,
                                    color: AppColors.mainApp,
                                    fontSize: 30,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomButton(
                  height: 50,
                  onPressed: () => Get.toNamed(Routes.editUser),
                  width: double.infinity,
                  child: CustomText(
                    LocaleKeys.updateAccount.tr,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: kBottomNavigationBarHeight + 20.0),
            ],
          ),
        );
      },
    );
  }
}
