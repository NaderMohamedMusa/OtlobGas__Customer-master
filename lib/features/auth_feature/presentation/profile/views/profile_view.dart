import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/profile/controllers/profile_controller.dart';

import '../../main_layout/views/components/main_layout_app_bar.dart';
import '../../../../rating_feature/presentation/orders_rating/views/orders_rating_view.dart';
import 'components/profile_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(getOrdersCountUseCase: Get.find()),
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: MainLayoutAppBar(
                /// Tabs bar
                tabs: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10.0),
                      const Icon(Icons.account_circle_outlined),
                      Text(
                        LocaleKeys.profile.tr,
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10.0),
                      const Icon(Icons.star_border_rounded),
                      Text(
                        LocaleKeys.reviewsOfOrders.tr,
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
              body: const TabBarView(
                children: [
                  ProfilePage(),
                  OrdersRatingView(),
                ],
              )),
        );
      },
    );
  }
}
