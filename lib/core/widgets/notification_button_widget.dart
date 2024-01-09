import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            if (Get.currentRoute != Routes.notifications) {
              Get.toNamed(Routes.notifications);
            }
          },
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      )),
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              UserService.to.currentUser.value!.countUnread > 0
                  ? const Positioned(
                      top: 15,
                      right: 0,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.red,
                      ))
                  : const SizedBox()
            ],
          ),
        ));
  }
}
