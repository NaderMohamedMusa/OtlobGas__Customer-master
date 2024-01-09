import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/back_button_widget.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../controllers/notifications_controller.dart';
import 'components/notification_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(
        getAllNotificationsUseCase: Get.find(),
        getTodayNotificationsUseCase: Get.find(),
        deleteAllNotificationsUseCase: Get.find(),
        deleteNotificationUseCase: Get.find(),
        readAllNotificationsUseCase: Get.find(),
      ),
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CustomAppBar(
              toolbarHeight: 106,
              title: Text(LocaleKeys.notifications.tr),
              actions: [
                GestureDetector(
                  onTap: () => Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      titlePadding: EdgeInsets.zero,
                      title: SizedBox(
                        width: Get.width,
                        child: Material(
                          elevation: 24,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  LocaleKeys
                                      .doYouWantToDeleteAllNotification.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Colors.black, fontSize: 22),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomButton(
                                      onPressed: () =>
                                          controller.deleteAllNotifications(),
                                      color: Colors.red,
                                      child: CustomText(
                                        LocaleKeys.yes.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    CustomButton(
                                      onPressed: () => Get.back(),
                                      color: AppColors.mainApp,
                                      child: CustomText(
                                        LocaleKeys.no.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
                    child: const Icon(Icons.delete_outline),
                  ),
                ),
                const SizedBox(width: 10.0),
                const BackButtonWidget(),
                const SizedBox(width: 10.0),
              ],

              /// Tabs bar
              tabs: [
                Tab(
                    child: Text(
                  LocaleKeys.todaysAlerts.tr,
                )),
                Tab(
                    child: Text(
                  LocaleKeys.previousAlerts.tr,
                )),
                /*   Tab(
                  child: Row(
                children: [
                  SvgPicture.asset(Assets.readActiveIC),
                  const SizedBox(width: 10),
                  Text(
                    Utils.localization?.read_all ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: AppColors.mainApp),
                  ),
                ],
              )), */
              ],
            ),
            body: TabBarView(
              children: [
                /// today notify
                CustomLoading(
                  isLoading: controller.isTodayLoading,
                  widget: controller.todayNotificationsContent.isEmpty &&
                          !controller.isTodayLoading
                      ? Center(
                          child: CustomText(
                            LocaleKeys.emptyNotifications.tr,
                          ),
                        )
                      : ListView.separated(
                          controller: controller.todayNotificationsScroll,
                          itemBuilder: (context, index) {
                            return NotificationCard(
                              notification:
                                  controller.todayNotificationsContent[index],
                              isTodayNotification: true,
                            );
                          },
                          itemCount:
                              controller.todayNotificationsContent.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              thickness: 1,
                              color: Colors.grey[300],
                            );
                          },
                        ),
                ),

                /// pervious notify
                CustomLoading(
                  isLoading: controller.isAllLoading,
                  widget: controller.allNotificationsContent.isEmpty &&
                          !controller.isAllLoading
                      ? Center(
                          child: CustomText(
                            LocaleKeys.emptyNotifications.tr,
                          ),
                        )
                      : ListView.separated(
                          controller: controller.allNotificationsScroll,
                          itemBuilder: (context, index) {
                            return NotificationCard(
                              notification:
                                  controller.allNotificationsContent[index],
                              isTodayNotification: false,
                            );
                          },
                          itemCount: controller.allNotificationsContent.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              thickness: 1,
                              color: Colors.grey[300],
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
