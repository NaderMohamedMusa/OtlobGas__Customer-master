import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/features/notifications_feature/domain/entities/notification_content.dart';

import '../../../../../../core/consts/assets.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../controllers/notifications_controller.dart';

class NotificationCard extends GetView<NotificationsController> {
  const NotificationCard({
    Key? key,
    required this.notification,
    required this.isTodayNotification,
  }) : super(key: key);
  final NotificationContent notification;
  final bool isTodayNotification;

  String getIcon(int status) {
    switch (status) {
      case 0:
        return Assets.bottPersonIC;
      case 1:
      case 5:
        return Assets.warning;
      case 2:
        return Assets.infoYellowIC;
      case 6:
        return Assets.messagesIC;

      case 7:
        return Assets.blockIC;

      case 8:
        return Assets.checkIC;

      default:
        return Assets.carBlueIC;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          SvgPicture.asset(
            getIcon(notification.status),
            height: 25,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomText(
              notification.message,
            ),
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () => controller.deleteNotification(
                      notification.id,
                      isTodayNotification,
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(Assets.closeIC),
                )),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
