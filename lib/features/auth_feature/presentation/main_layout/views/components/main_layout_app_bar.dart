import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_cached_image.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../core/widgets/drawer_icon.dart';
import '../../../../../../core/widgets/notification_button_widget.dart';

class MainLayoutAppBar extends GetView<UserService> implements PreferredSizeWidget {
  const MainLayoutAppBar({Key? key, this.tabs}) : super(key: key);
  final List<Widget>? tabs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomAppBar(
        tabs: tabs,
        toolbarHeight: preferredSize.height,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              controller.currentUser.value?.name ?? LocaleKeys.guest.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeightManger.bold, color: Colors.white),
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  Assets.starFilled,
                  height: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  controller.currentUser.value?.rate ?? '0',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          NotificationButton(),
          SizedBox(width: 10),
          DrawerIcon(),
          SizedBox(width: 10),
        ],
        leading: Container(
          margin: const EdgeInsets.only(right: 10),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CustomCachedNetworkImage(
            url: controller.currentUser.value?.image ?? '',
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((tabs != null ? 2.2 : 1) * kToolbarHeight + 20);
}
